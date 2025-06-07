#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Minecraft Server Setup...${NC}"

# Update package list
echo -e "${GREEN}Updating package list...${NC}"
sudo apt-get update

# Install Java
echo -e "${GREEN}Installing Java...${NC}"
sudo apt-get install -y openjdk-17-jdk

# Install cloudflared
echo -e "${GREEN}Installing cloudflared...${NC}"
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
rm cloudflared-linux-amd64.deb

# Create server directory
echo -e "${GREEN}Creating server directory...${NC}"
mkdir -p ~/minecraft-server
cd ~/minecraft-server

# Download server jar (using latest version)
echo -e "${GREEN}Downloading Minecraft server...${NC}"
wget https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar -O server.jar

# Accept EULA
echo -e "${GREEN}Accepting EULA...${NC}"
echo "eula=true" > eula.txt

# Create startup script
echo -e "${GREEN}Creating Minecraft startup script...${NC}"
cat > start.sh << 'EOF'
#!/bin/bash
java -Xmx2G -Xms2G -jar server.jar nogui
EOF

chmod +x start.sh

# Create basic server.properties
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

# Create cloudflared tunnel startup script
echo -e "${GREEN}Creating Cloudflared tunnel startup script...${NC}"
cat > start_tunnel.sh << 'EOF'
#!/bin/bash
cloudflared tunnel --url tcp://localhost:25565
EOF

chmod +x start_tunnel.sh

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}To start the Minecraft server, run:${NC}"
echo "cd ~/minecraft-server && ./start.sh"
echo -e "${GREEN}To expose the server via Cloudflare Tunnel, run:${NC}"
echo "cd ~/minecraft-server && ./start_tunnel.sh"
echo -e "${GREEN}You will receive a Cloudflare hostname to share with players.${NC}"
