#!/usr/bin/env bash

# Functions
manualDownload () {
  echo "${1} ${2}" >> manual.txt
}

buildJar () {
  cd build
  git clone "${2}"
  cd ${1}
  eval ${3}
  cd ../..
  eval cp build/${1}/${4} jar/
}

ciDownload () {
  cd ci
  mkdir "${1}"
  cd ${1}
  wget "${2}"
  if [ -n "${4}" ]
  then
    unzip ${4}
  fi
  cd ../..
  eval cp ci/${1}/${3} jar/
}

gitDownload () {
  cd git
  mkdir "${1}" && cd "${1}" && wget "$(curl -s ${2} | jq -r .assets[].browser_download_url)"
  cd ../..
  eval cp git/${1}/${3} jar/
}

# Setup
rm -rf build && rm -rf jar && rm -rf ci && rm -rf git && rm manual.txt
mkdir build && mkdir jar && mkdir ci && mkdir git
touch manual.txt

# Animatronics
#we must use alternatives as this plugin is the bane of my mortal existence
#manualDownload Animatronics "https://www.spigotmc.org/resources/animatronics-animate-armorstands-1-8-1-17-1.36518/history"

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
# Currently broken, but we should do this ourselves anyways
#manualDownload GSit "https://www.spigotmc.org/resources/gsit-modern-sit-seat-and-chair-lay-and-crawl-plugin-1-13-x-1-17-x.62325/history"

# HeadDatabase
manualDownload HeadDatabase "https://www.spigotmc.org/resources/head-database.14280/history"

# LiteBans
manualDownload LiteBans "https://www.spigotmc.org/resources/litebans.3715/history"

# LuckPerms
ciDownload LuckPerms "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/*zip*/libs.zip" libs/LuckPerms-Bukkit-*.jar libs.zip

# OpenAudioMC
cd build
# OpenAudio is special and thus we must build and install its special dependency to our local maven repo first
git clone "https://github.com/Mindgamesnl/OpenAudioMc.git" && cd OpenAudioMc/jutils && mvn clean install -T100 && cd ../plugin && mvn clean package -T100
cd ../../..
cp build/OpenAudioMc/plugin/target/OpenAudioMc-*.jar jar/

# ParadisuPlugin
gitDownload ParadisuPlugin "https://api.github.com/repos/Paradisu/ParadisuPlugin/releases/latest" ParadisuPlugin-*.jar

# PlaceholderAPI
buildJar PlaceholderAPI "https://github.com/PlaceholderAPI/PlaceholderAPI.git" "/bin/bash ./gradlew build" build/libs/PlaceholderAPI-*-null.jar

# PlayerVaultsX
buildJar PlayerVaults "https://github.com/drtshock/PlayerVaults.git" "mvn clean package -T100" target/PlayerVaultsX.jar

# ProtocolLib
gitDownload ProtocolLib "https://api.github.com/repos/dmulloy2/ProtocolLib/releases/latest" ProtocolLib.jar

# ServerListsPlus
#deprecated
#ciDownload ServerListsPlus "https://ci.codemc.io/job/Minecrell/job/ServerListPlus/lastSuccessfulBuild/artifact/build/libs/*zip*/libs.zip" libs/ServerListPlus-*-SNAPSHOT-Universal.jar libs.zip

# ShopKeepers
SHOPKEEPERS_VERSION=$(curl -s "https://nexus.lichtspiele.org/repository/releases/com/nisovin/shopkeepers/Shopkeepers/maven-metadata.xml" | xq -r .metadata.versioning.release)
ciDownload ShopKeepers "https://nexus.lichtspiele.org/repository/releases/com/nisovin/shopkeepers/Shopkeepers/${SHOPKEEPERS_VERSION}/Shopkeepers-${SHOPKEEPERS_VERSION}.jar" Shopkeepers-*.jar

# TAB
gitDownload TAB "https://api.github.com/repos/NEZNAMY/TAB/releases/latest" TAB.v*.jar

# TCCoasters
ciDownload TCCoasters "https://ci.mg-dev.eu/job/TC%20Coasters/lastSuccessfulBuild/artifact/*zip*/archive.zip" archive/target/TCCoasters-*.jar archive.zip

# TrainCarts
ciDownload TrainCarts "https://ci.mg-dev.eu/job/TrainCarts/lastSuccessfulBuild/artifact/*zip*/archive.zip" archive/target/TrainCarts-*.jar archive.zip

# Vault
gitDownload Vault "https://api.github.com/repos/MilkBowl/Vault/releases/latest" Vault.jar

# VentureChat
export JAVA_HOME=/usr/lib/jvm/java-16-openjdk-amd64
buildJar venturechat "https://bitbucket.org/Aust1n46/venturechat.git" "mvn clean package -T100" target/VentureChat-*.jar
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# WorldEdit
buildJar WorldEdit "https://github.com/EngineHub/WorldEdit.git" "/bin/bash ./gradlew :worldedit-bukkit:build" worldedit-bukkit/build/libs/worldedit-bukkit-*-dist.jar

# WorldGuard
buildJar WorldGuard "https://github.com/EngineHub/WorldGuard.git" "/bin/bash ./gradlew build" worldguard-bukkit/build/libs/worldguard-bukkit-*-dist.jar

# Yamipa
#removed for now
#gitDownload Yamipa "https://api.github.com/repos/josemmo/yamipa/releases/latest" YamipaPlugin-*.jar

# Finish Up
echo
cat "manual.txt"
