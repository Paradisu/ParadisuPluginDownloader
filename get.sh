#!/usr/bin/env bash

# Functions
manualDownload () {
  echo "${1} must be downloaded manually at ${2}"
  open ${2}
}

buildJar () {
  cd build
  git clone ${2} && cd ${1} && ${3}
  cd ../..
  cp build/${1}/${4} jar/
}

ciDownload () {
  cd ci
  mkdir ${1} && cd ${1} && wget ${2} && [[ ! -z ${4} ]] && unzip ${4}
  cd ../..
  cp ci/${1}/${3} jar/
}

gitDownload () {
  cd git
  mkdir ${1} && cd ${1} && wget $(curl -s ${2} | jq -r .assets[].browser_download_url)
  cd ../..
  cp git/${1}/${3} jar/
}

# Setup
rm -rf build && rm -rf jar && rm -rf ci && rm -rf git
mkdir build && mkdir jar && mkdir ci && mkdir git

# Animatronics
manualDownload Animatronics "https://www.spigotmc.org/resources/animatronics-animate-armorstands-1-8-1-17-1.36518/history"

# ArmorStandTools
buildJar ArmorStandTools "https://github.com/St3venAU/ArmorStandTools.git" "mvn clean package -T100" target/ArmorStandTools-*.jar

# BKCommonLib
ciDownload BKCommonLib "https://ci.mg-dev.eu/job/BKCommonLib/lastSuccessfulBuild/artifact/target/*zip*/target.zip" target/BKCommonLib-*.jar target.zip

# Citizens
ciDownload Citizens "https://ci.citizensnpcs.co/job/Citizens2/lastSuccessfulBuild/artifact/dist/target/*zip*/target.zip" target/Citizens-*.jar target.zip

# CoreProtect
gitDownload CoreProtect "https://api.github.com/repos/PlayPro/CoreProtect/releases/latest" CoreProtect-*.jar

# DiscordSRV
gitDownload DiscordSRV "https://api.github.com/repos/DiscordSRV/DiscordSRV/releases/latest" DiscordSRV-Build-*.jar

# EasyBackup
manualDownload EasyBackup "https://www.spigotmc.org/resources/%E2%AD%90-easybackup-%E2%AD%90-easy-and-powerful-backup-service-protecting-servers-since-2015.8017/history"

# ForceResourcepacks
manualDownload ForceResourcepacks "https://www.spigotmc.org/resources/force-resourcepacks.10499/history"

# GSit
manualDownload GSit "https://www.spigotmc.org/resources/gsit-modern-sit-seat-and-chair-lay-and-crawl-plugin-1-13-x-1-17-x.62325/history"

# HeadDatabase
manualDownload HeadDatabase "https://www.spigotmc.org/resources/head-database.14280/history"

# LiteBans
manualDownload LiteBans "https://www.spigotmc.org/resources/litebans.3715/history"

# LuckPerms
ciDownload LuckPerms "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/*zip*/libs.zip" libs/LuckPerms-Bukkit-*.jar libs.zip

# OpenAudioMC
cd build
export JAVA_HOME=`/usr/libexec/java_home -v 11`
git clone "https://github.com/Mindgamesnl/OpenAudioMc.git" && cd OpenAudioMc/plugin && mvn clean package -T100
export JAVA_HOME=`/usr/libexec/java_home -v 16`
cd ../../..
cp build/OpenAudioMc/plugin/target/OpenAudioMc-*.jar jar/

# ParadisuPlugin
gitDownload ParadisuPlugin "https://api.github.com/repos/Paradisu/ParadisuPlugin/releases/latest" ParadisuPlugin-*.jar

# PlaceholderAPI
gitDownload PlaceholderAPI "https://api.github.com/repos/PlaceholderAPI/PlaceholderAPI/releases/latest" PlaceholderAPI-*.jar

# PlayerVaultsX
buildJar PlayerVaultsX "https://github.com/drtshock/PlayerVaults.git" "mvn clean package -T100" target/PlayerVaultsX.jar

# ProtocolLib
gitDownload ProtocolLib "https://api.github.com/repos/dmulloy2/ProtocolLib/releases/latest" ProtocolLib.jar

# ServerListsPlus
ciDownload ServerListsPlus "https://ci.codemc.io/job/Minecrell/job/ServerListPlus/lastSuccessfulBuild/artifact/build/libs/*zip*/libs.zip" libs/ServerListPlus-*-SNAPSHOT-Universal.jar libs.zip

# ShopKeepers
SHOPKEEPERS_VERSION=$(curl -s "https://nexus.lichtspiele.org/repository/releases/com/nisovin/shopkeepers/Shopkeepers/maven-metadata.xml" | xq -r .metadata.versioning.release)
ciDownload ShopKeepers "https://nexus.lichtspiele.org/repository/releases/com/nisovin/shopkeepers/Shopkeepers/${SHOPKEEPERS_VERSION}/Shopkeepers-${SHOPKEEPERS_VERSION}.jar" Shopkeepers-*.jar

# TAB
cd build
git clone "https://github.com/NEZNAMY/TAB.git" && cd TAB
sed -i '' 's/return false;/return true;/g' shared/src/main/java/me/neznamy/tab/shared/TAB.java
mvn clean package -T100
cd ../..
cp build/TAB/jar/target/TAB-*.jar jar/

# TCCoasters
ciDownload TCCoasters "https://ci.mg-dev.eu/job/TC%20Coasters/lastSuccessfulBuild/artifact/*zip*/archive.zip" archive/target/TCCoasters-*.jar archive.zip

# TrainCarts
ciDownload TrainCarts "https://ci.mg-dev.eu/job/TrainCarts/lastSuccessfulBuild/artifact/*zip*/archive.zip" archive/target/TrainCarts-*.jar archive.zip

# Vault
gitDownload Vault "https://api.github.com/repos/MilkBowl/Vault/releases/latest" Vault.jar

# VentureChat
buildJar VentureChat "https://bitbucket.org/Aust1n46/venturechat.git" "mvn clean package -T100" target/VentureChat-*.jar

# WorldEdit
WORLDEDIT_VERSION=$(curl -s "https://maven.enginehub.org/repo/com/sk89q/worldedit/worldedit-bukkit/maven-metadata.xml" | xq -r .metadata.versioning.latest)
ciDownload WorldEdit "https://ci.enginehub.org/repository/download/bt10/lastSuccessful/worldedit-bukkit-${WORLDEDIT_VERSION}-dist.jar" worldedit-bukkit-*-dist.jar

# WorldGuard
WORLDGUARD_VERSION=$(curl -s "https://maven.enginehub.org/artifactory/repo/com/sk89q/worldguard/worldguard-bukkit/maven-metadata.xml" | xq -r .metadata.versioning.latest)
ciDownload WorldGuard "https://ci.enginehub.org/repository/download/bt11/lastSuccessful/worldguard-bukkit-${WORLDGUARD_VERSION}-dist.jar" worldguard-bukkit-*-dist.jar

# Yamipa
gitDownload Yamipa "https://api.github.com/repos/josemmo/yamipa/releases/latest" YamipaPlugin-*.jar
