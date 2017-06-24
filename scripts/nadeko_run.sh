#!/bin/sh
clientid="326544509016080395"
botid="326544509016080395"
token="zI2NTQ0NTA5MDE2MDgwMzk1.DCtUyQ.4cPXP-5et2Qv7ieZPblrbwe8Bd8"
ownerid="226083477177630720,123958998490808320"
googleapi=""
lolapikey=""
mashapekey=""
osu=""
scid=""
connection="my.gearhost.com=;mssql3.gear.host=;aikodb ID=;Pz8v2!_O9iHe"

echo "NadekoBot 1.3b"

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi
root=$(pwd)
echo "Restoring Nadeko dependencies"
cd $root/NadekoBot/Discord.Net/src/Discord.Net.Core/
dotnet restore 1>/dev/null 2>&1
cd $root/NadekoBot/Discord.Net/src/Discord.Net.Rest/
dotnet restore 1>/dev/null 2>&1
cd $root/NadekoBot/Discord.Net/src/Discord.Net.WebSocket/
dotnet restore 1>/dev/null 2>&1
cd $root/NadekoBot/Discord.Net/src/Discord.Net.Commands/
dotnet restore 1>/dev/null 2>&1
cd $root/NadekoBot/src/NadekoBot/
dotnet restore 1>/dev/null 2>&1
echo ""
echo "Restoring done"

echo "Building NadekoBot"
cd $root/NadekoBot/src/NadekoBot/
dotnet build --configuration Release 1>/dev/null 2>&1
echo ""
echo "Installation Complete."

echo "Creating a new credentials.json"

echo "{
  \"ClientId\": $clientid,
  \"BotId\": $botid,
  \"Token\": \"$token\",
  \"OwnerIds\": [
    $ownerid
  ],
  \"LoLApiKey\": \"$lolapikey\",
  \"GoogleApiKey\": \"$googleapi\",
  \"MashapeKey\": \"$mashapekey\",
  \"OsuApiKey\": \"$osu\",
  \"SoundCloudClientId\": \"$scid\",
  \"Db\": {\"Type\": \"sqlserver\", \"ConnectionString\": \"$connection\"},
  \"TotalShards\": 1
}" | cat - >> credentials.json
sleep 5
cd -

cd $root/NadekoBot/src/NadekoBot
echo "Running NadekoBot. Please wait."
dotnet run --configuration Release
echo "Done"

exit 0

echo "Running NadekoBot with auto restart normally!"
sleep 5s
cd $root/NadekoBot/src/NadekoBot
while :; do dotnet run -c Release; sleep 5s; done
echo ""
echo "That didn't work? Please report to ScarletKuro"
sleep 3s
echo "Done"
exit 0
