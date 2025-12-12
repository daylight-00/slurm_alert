# Slurm Alert

A system for receiving real-time Slack notifications when your Slurm jobs start and finish.

## Features

- Automatic Slack notifications for job start/completion
- Detailed job information and execution time logging
- Simple function-based API
- Easy integration into existing job scripts

## Prerequisites

### 1. Create a Slack App

1. Create a new app at [Slack API](https://api.slack.com/apps)
2. Add the following scopes under **OAuth & Permissions** > **Scopes**:
   - `chat:write`
   - `chat:write.public`
3. Click **Install App** to install it to your workspace
4. Copy the **Bot User OAuth Token** (format: `xoxb-...`)

### 2. Get Your Channel ID

1. In Slack, right-click on the bot app > **View app details**
2. Copy the **Channel ID**

## Installation

### System-wide Setup (Administrator)

```bash
# Copy .slurmrc to a shared directory
sudo cp .slurmrc /apps/.slurmrc

# Configure the Bot Token
sudo nano /apps/.slurmrc
# Replace BOT_USER_TOKEN with your actual token
```

### Personal Setup (Individual User)

```bash
# Copy .slurmrc to your home directory
cp .slurmrc ~/.slurmrc

# Configure the token
nano ~/.slurmrc
# Replace BOT_USER_TOKEN with your actual token
```

## Usage

### 1. Load Functions

```bash
source /apps/.slurmrc  # or source ~/.slurmrc
```

### 2. Use in Job Scripts

```bash
#!/bin/bash
#SBATCH [options...]

source /apps/.slurmrc
slurm_start YOUR_CHANNEL_ID

# Your actual job commands
python train.py
# ...

slurm_end YOUR_CHANNEL_ID
```

See [example_job.sh](example_job.sh) for a complete example.

## Notification Examples

```
[Job 12345] Started on gpu-node-01
[Job 12345] Finished in 3600 seconds
```

## Testing

```bash
# Test message sending
MESSAGE="Test message"
BOT_USER_TOKEN="xoxb-your-token"
BOT_CHANNEL_ID="YOUR_CHANNEL_ID"

curl -s -X POST -H "Authorization: Bearer $BOT_USER_TOKEN" \
  -H 'Content-type: application/json; charset=utf-8' \
  --data "{\"channel\":\"$BOT_CHANNEL_ID\", \"text\":\"$MESSAGE\"}" \
  https://slack.com/api/chat.postMessage
```
