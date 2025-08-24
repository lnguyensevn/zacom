#!/bin/bash

# Create or clear the log file
echo "" > zacom_log.txt

# 30% chance to execute the commit logic
if (( RANDOM % 100 < 30 )); then
  echo "Today is a commit day!"
  num_commits=1

  # 60% chance for 1-5 commits, 40% for 6-12 commits
  if (( RANDOM % 100 < 60 )); then
    # 1 to 5 commits
    num_commits=$((1 + RANDOM % 5))
  else
    # 6 to 12 commits
    num_commits=$((6 + RANDOM % 7))
  fi
  
  echo "Committing $num_commits times today."
  current_date=$(date +%Y-%m-%d)

  for (( i=1; i<=num_commits; i++ )); do
    # Format seconds with a leading zero for consistency
    formatted_seconds=$(printf "%02d" "$i")

    # Add a line to file
    echo "Commit $i on $current_date" >> zacom_log.txt
    
    # Git add and commit with custom date
    git add zacom_log.txt
    GIT_AUTHOR_DATE="$current_date 12:00:$formatted_seconds" \
    GIT_COMMITTER_DATE="$current_date 12:00:$formatted_seconds" \
    git commit -m "Zacom commit $i for $current_date"
  done

  if [ $num_commits -gt 0 ]; then
    git push -u origin main
    echo "Successfully committed $num_commits times today."
  else
    echo "No commits were made today."
  fi
else
  echo "No commits today."
fi