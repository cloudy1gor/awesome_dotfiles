#!/bin/sh

get_icon() {
    case $1 in
        # Clear sky (day)
        01d) icon="";;
        
        # Clear sky (night)
        01n) icon="󰖔";;
        
        # Few clouds (day)
        02d) icon="󰖕";;
        
        # Few clouds (night)
        02n) icon="󰼱";;
        
        # Scattered clouds (any time)
        03*) icon="";;
        
        # Broken clouds (any time)
        04*) icon="";;
        
        # Shower rain (day)
        09d) icon="";;
        
        # Shower rain (night)
        09n) icon="";;
        
        # Rain (day)
        10d) icon="";;
        
        # Rain (night)
        10n) icon="";;
        
        # Thunderstorm (day)
        11d) icon="";;
        
        # Thunderstorm (night)
        11n) icon="";;
        
        # Snow (day)
        13d) icon="";;
        
        # Snow (night)
        13n) icon="'";;
        
        # Mist (day)
        50d) icon="";;
        
        # Mist (night)
        50n) icon="";;
        
        # Default icon for any other condition
        *) icon="󰖐";;  

    esac

    echo $icon
}

KEY="d3a17d0b3c41b2d7e84ef56e36ad5cd0"
CITY="706483"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "$(get_icon $weather_icon) $weather_temp$SYMBOL"
fi
