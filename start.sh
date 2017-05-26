#!/bin/sh -ex

cd /share/jobs-producer-1.0

if [ "$RUNNING_MODULE" = "task_watch" ]; then
	php src/TaskWatchApp.php 2>&1
elif [ "$RUNNING_MODULE" = "task_consumer" ]; then
	php src/TaskConsumerApp.php 2>&1
elif [ "$RUNNING_MODULE" = "task_process" ]; then
	php src/TaskProcessConsumerApp.php 2>&1
fi

