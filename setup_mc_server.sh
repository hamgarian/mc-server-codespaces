#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Minecraft Server Setup with Playit.gg...${NC}"

# Update package list
echo -e "${GREEN}Updating package list...${NC}"
sudo apt-get update

# Install Java and dependencies
echo -e "${GREEN}Installing Java and dependencies...${NC}"
sudo apt-get install -y openjdk-17-jdk curl jq unzip gnupg

# Create server directory
echo -e "${GREEN}Creating server directory...${NC}"
mkdir -p ~/minecraft-server
cd ~/minecraft-server

# Fetch latest Minecraft server version
echo -e "${GREEN}Fetching latest Minecraft server version...${NC}"
VERSION_MANIFEST_URL="https://piston-meta.mojang.com/mc/game/version_manifest_v2.json"
LATEST_VERSION=$(curl -s $VERSION_MANIFEST_URL | jq -r '.latest.release')
VERSION_URL=$(curl -s $VERSION_MANIFEST_URL | jq -r --arg ver "$LATEST_VERSION" '.versions[] | select(.id == $ver) | .url')
SERVER_JAR_URL=$(curl -s "$VERSION_URL" | jq -r '.downloads.server.url')

# Download Minecraft server jar
echo -e "${GREEN}Downloading Minecraft $LATEST_VERSION server jar...${NC}"
wget "$SERVER_JAR_URL" -O server.jar

# Accept EULA
echo -e "${GREEN}Accepting EULA...${NC}"
echo "eula=true" > eula.txt

# Create Minecraft startup script
echo -e "${GREEN}Creating Minecraft startup script...${NC}"
cat > start.sh << 'EOF'
#!/bin/bash
java -Xmx2G -Xms2G -jar server.jar nogui
EOF

chmod +x start.sh

# Create server.properties file
echo -e "${GREEN}Creating server.properties...${NC}"
cat > server.properties << 'EOF'
server-port=25565
max-players=20
view-distance=10
simulation-distance=10
gamemode=survival
difficulty=normal
pvp=true
spawn-protection=16
online-mode=true
white-list=false
enable-command-block=false
motd=Welcome to Minecraft Server!
EOF

# Install Playit.gg via official APT repository
echo -e "${GREEN}Installing Playit.gg tunnel agent via APT...${NC}"
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
sudo apt update
sudo apt install -y playit

# Create Playit tunnel startup script
echo -e "${GREEN}Creating Playit tunnel startup script...${NC}"
cat > start_tunnel.sh << 'EOF'
#!/bin/bash
playit
EOF

chmod +x start_tunnel.sh

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}Minecraft version: $LATEST_VERSION${NC}"
echo -e "${GREEN}To start the Minecraft server, run:${NC}"
echo "cd ~/minecraft-server && ./start.sh"
echo -e "${GREEN}To expose the server via Playit.gg, run:${NC}"
echo "cd ~/minecraft-server && ./start_tunnel.sh"
echo -e "${GREEN}You will receive a playit.gg address to share with players.${NC}"
