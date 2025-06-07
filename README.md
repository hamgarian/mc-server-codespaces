# Minecraft Server on GitHub Codespaces using Playit.gg

![image](https://github.com/user-attachments/assets/5c467ae7-9328-4d5e-b2fe-471ddba02100)<br/>
<sub><i>82 ping on GitHub Codespaces Asia Region, playit.gg Anycast Global Region</i></sub>


This project lets you **host a Minecraft Java Edition server** inside a **GitHub Codespace**, with public access enabled through [Playit.gg](https://playit.gg).

> ⚠️ **Note:** GitHub Codespaces aren't designed for long-term server hosting. You may only get **up to ~30 hours/month** on the highest-performance machines for free.

---

## 💡 Features

- 🚀 Launches a Minecraft server in a Codespace with 16 GB RAM (depending on region & machine type).
- 🌍 Easily share your server via **Playit.gg tunneling** (free and firewall-friendly).
- 🔄 Automatically fetches the **latest release** of Minecraft server.
- ⚙️ Generates all required configs and startup scripts.
- 🐧 Built for Ubuntu-based Codespace environments.

---

## 🛠️ Requirements

- A GitHub account with Codespaces access.
- A [Playit.gg](https://playit.gg) account (for persistent tunnels and easier management).
- (Optional) A GitHub Pro or Teams plan for more Codespace hours.

---

## 🚀 Getting Started

### 1. **Create Codespace**

Click the green **"Code"** button on this repo → **"Create codespace on main"**

> 💡 You can select the region and machine type (e.g., 4 cores, 16GB RAM) when creating the codespace.

---

### 2. **Run Setup Script**

Once inside the Codespace terminal, run:

```bash
chmod +x setup.sh
./setup.sh
```
This will:

- Install Java & dependencies
- Download the latest Minecraft server
- Set up the world and server config
- Install Playit.gg tunnel agent
- Create start scripts for server and tunnel

🧩 Files Created

- ~/minecraft-server/server.jar: Latest Minecraft server.
- ~/minecraft-server/server.properties: Default config.
- ~/minecraft-server/start.sh: Starts Minecraft server (2G RAM by default).
- ~/minecraft-server/start_tunnel.sh: Starts Playit tunnel agent.
- ~/minecraft-server/eula.txt: EULA acceptance.

▶️ Running the Server

1. Start Minecraft Server

```bash
cd ~/minecraft-server
./start.sh
```
▶️ Start Tunnel with Playit.gg

```bash
cd ~/minecraft-server
./start_tunnel.sh
```
You'll get a link like:  
your-server.playit.gg:12345  
Share this with your friends to connect!

⚙️ Customization

- Modify `start.sh` to change RAM usage (e.g., `-Xmx4G`).
- Edit `server.properties` to configure gameplay settings.
- Use `/op <username>` in Minecraft console to grant yourself admin.

⏳ Limits

GitHub Codespaces are not designed for 24/7 servers. Free-tier usage is limited:

| Machine Type        | Monthly Hours | Notes                        |
|---------------------|---------------|------------------------------|
| 2 cores, 8 GB RAM    | 60 hrs       | Standard performance            |
| 4 cores, 16 GB RAM   | 30 hrs        | Higher Performance             |

📦 Future Improvements

- Auto-backup world saves to repo
- Add whitelist support
- Optional plugin/mod installation
- Auto-start on Codespace boot

🙏 Acknowledgements

- Minecraft
- Playit.gg - Free tunnel service for games
- GitHub Codespaces - Dev environments in the cloud

📜 License

This project is released under the MIT License.
