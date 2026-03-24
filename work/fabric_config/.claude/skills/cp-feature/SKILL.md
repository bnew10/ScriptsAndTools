---
name: cp-feature
description: Copy feature branch commits to a new branch based on a different parent. Use when asked to port, copy, or cherry-pick a feature branch to another release version.
argument-hint: <source-branch> <new-branch>
allowed-tools: Bash, Read, Grep, Edit, Write, Glob, AskUserQuestion
disable-model-invocation: true
---

# Copy Feature Branch to New Parent

You are copying commits from a source feature branch to a new feature branch based on a different parent/release branch. Follow these steps carefully and interactively.

## Arguments

- Source branch: `$0`
- New branch: `$1`

If either argument is missing, display this usage message and stop:
```
Usage: /cp-feature <source-branch> <new-branch>

Example: /cp-feature accxd_530_analyzing_progress_5.6.0 accxd_530_analyzing_progress_5.6.1

Copies commits from the source feature branch into a new branch based on a different parent.
The parent branches are derived from the version suffix (e.g., _5.6.0 -> origin/5.6.0).
```

## Step 1: Parse and Validate

1. Extract the version from each branch name by taking the last `_`-delimited segment:
   - Source version from `$0` (e.g., `accxd_530_analyzing_progress_5.6.0` -> `5.6.0`)
   - Target version from `$1` (e.g., `accxd_530_analyzing_progress_5.6.1` -> `5.6.1`)

2. Derive parent branches: `origin/<source-version>` and `origin/<target-version>`

3. Run `git fetch origin` to ensure remote refs are up to date.

4. Validate:
   - Both parent branches exist: `git rev-parse --verify origin/<version>` for each
   - Source branch exists (locally or on remote): check `git rev-parse --verify $0` or `git rev-parse --verify origin/$0`
   - New branch does NOT already exist locally: `git rev-parse --verify $1` should fail

   If any validation fails, report the error clearly and stop.

## Step 2: Identify Commits to Copy

Check if the source branch has already been merged into its parent:

```bash
git log --oneline --reverse origin/<source-version>..$0
```

- **If this returns commits** -> the source branch has NOT been merged yet. Proceed with **Path A**.
- **If this returns nothing** -> the source branch has been merged into its parent. Proceed with **Path B**.

Display the identified commits or merge info to the user and ask for confirmation before proceeding.

## Step 3: Create the New Branch

```bash
git checkout -b $1 origin/<target-version>
```

## Step 4 — Path A: Cherry-pick Each Commit (source branch NOT yet merged)

For each commit SHA from Step 2 (in chronological order):

1. Show the user which commit you're about to apply (SHA + message).

2. Attempt the cherry-pick:
   ```bash
   git cherry-pick --no-commit <sha>
   ```

3. Check the result:

   **If clean (exit code 0):**
   - The changes are staged in the working tree. Create the commit with the original message, but replace the source version with the target version. For example, if the original message is `accxd-530 (5.6.0) - adds property for enabling/disabling JobWatcherService`, the new message becomes `accxd-530 (5.6.1) - adds property for enabling/disabling JobWatcherService`.
   - Use a HEREDOC for the commit message to preserve formatting.
   - Move to the next commit.

   **If conflicts or failure (non-zero exit code):**
   - Run `git cherry-pick --abort` to clean up the failed cherry-pick state.
   - Show the user the original commit's diff: `git show <sha>`
   - Show what files would be affected and the current state of those files in the new branch.
   - Use AskUserQuestion to confirm the user wants to proceed with manual adaptation.
   - Read the relevant files, understand the differences, and apply the changes manually using Edit/Write tools. Work with the user interactively to resolve any issues.
   - Once the user is satisfied, stage the changes with `git add` and create the commit with the version-updated message (same format as clean apply).

4. After each commit, show a brief status: which commit was applied and how many remain.

## Step 4 — Path B: Single Commit from Merge (source branch already merged)

When the source branch has already been merged into its parent:

1. Find the merge commit that merged the source branch into its parent:
   ```bash
   git log --oneline --merges --grep="$0" origin/<source-version>
   ```
   Take the most recent (first) result. If no merge commit is found with the branch name, try searching with variations or ask the user for help identifying the merge commit.

2. Get the diff introduced by that merge:
   ```bash
   git diff <merge-commit>~1..<merge-commit>
   ```
   Also examine the merge commit's history to find the individual feature commits and their messages:
   ```bash
   git log --oneline <merge-commit>^1..<merge-commit>^2
   ```

3. Apply the changes to the new branch. For each changed file:
   - Read the current state of the file in the new branch
   - Read the diff from the merge commit
   - Apply the changes using Edit/Write tools, adapting as needed for the target branch
   - If a file doesn't exist in the target branch or the surrounding code is significantly different, work with the user interactively to resolve

4. Extract the Jira issue key from the source branch name or commit messages. The key format is typically letters-digits (e.g., `accxd-530`, `cmdxd-951`). To extract from the branch name, take the portion before the version-like segments, convert underscores to hyphens, and identify the Jira key pattern.

5. Summarize the changes by reading the original commit messages from the merge.

6. Create a single commit with message format:
   ```
   <jira-issue-key> (<target-version>) - <summary of changes>
   ```
   For example: `accxd-530 (5.6.1) - adds analyzing progress tracking for jobs`

   Use AskUserQuestion to show the user the proposed commit message and let them confirm or edit it before committing.

## Step 5: Summary

After all commits have been applied:

1. Show the final commit log:
   ```bash
   git log --oneline origin/<target-version>..$1
   ```

2. Report:
   - Total commits created on the new branch
   - Which commits (if any) required manual conflict resolution
   - The new branch name and its parent branch

3. Remind the user that the new branch is local and has not been pushed. They can push it when ready with `git push -u origin $1`.
