#!/bin/sh

# Escape code
#esc=`echo "\033"`

# Set colors
#cc_red="${esc}[0;31m"
#cc_green="${esc}[0;32m"
#cc_yellow="${esc}[0;33m"
#cc_blue="${esc}[0;34m"
#cc_normal=`echo "${esc}[m\017"`

#echo "Here's ${cc_green}some green text${cc_normal} for you."
#echo "Here's ${cc_blue}some green text${cc_normal} for you."

# Configure device names from commande line
PAD_DEVICE_NAME=$(xsetwacom list devices |grep 'type: PAD' | /usr/bin/awk -F\ \  '{print $1}')
STYLUS_DEVICE_NAME=$(xsetwacom list devices |grep 'type: STYLUS' | /usr/bin/awk -F\ \  '{print $1}')
ERASER_DEVICE_NAME=$(xsetwacom list devices |grep 'type: ERASER' | /usr/bin/awk -F\ \  '{print $1}')

check() {
  #echo "Pad device name: \t $PAD_DEVICE_NAME"
  #echo "Stylus device name: \t $STYLUS_DEVICE_NAME"
  #echo "Eraser device name: \t $ERASER_DEVICE_NAME"

  if [ -z "$PAD_DEVICE_NAME" ] ; then
    logger -s "[ KO ] No Pad device name found!"
    return 1
  fi

  if [ -z "$STYLUS_DEVICE_NAME" ] ; then
    logger -s "[ KO ] No Stylus device name found!"
    return 1
  fi

  if [ -z "$ERASER_DEVICE_NAME" ] ; then
    logger -s "[ KO ] No Eraser device name found!"
    return 1
  fi
}

log_devices() {
  logger -s $(xsetwacom list devices)
}

# Configuration du Stylet
defaultStylusConfig()
{
  # bouton 2 stylet clique droit:
  xsetwacom --set "$STYLUS_DEVICE_NAME" button 2 "3"
  # bouton 3 stylet double clic:
  xsetwacom --set "$STYLUS_DEVICE_NAME" button 3 "button 1 button 1"

}
# Configuration du Pad
defaultPadConfig()
{
  # xsetwacom --set "$PAD_DEVICE_NAME"
  # haut gauche
  xsetwacom --set "$PAD_DEVICE_NAME" button 3 "key alt left"
  # bas gauche
  xsetwacom --set "$PAD_DEVICE_NAME" button 1 "key a"
  # haut droit
  xsetwacom --set "$PAD_DEVICE_NAME" button 9 "key alt right"
  # bas droit
  xsetwacom --set "$PAD_DEVICE_NAME" button 8 "key alt tab"
  return 0
}

# Configuration de l'effaceur
defaultEraserConfig()
{
  # xsetwacom --set "$ERASER_DEVICE_NAME"
  return 0
}

case "$1" in
  help)
    man xsetwacom
    ;;
  check)
    check
    if [ $? -eq 0 ] ; then
      echo "[ OK ] Wacom devices found"
      exit 0
    else
      echo "[ KO ] Wacom devices not found. \n$(xsetwacom list devices)"
      exit 1
    fi
    ;;
  *)
    check
    if [ $? -eq 0 ] ; then
      defaultStylusConfig
      defaultPadConfig
      defaultEraserConfig
      logger -s "[ OK ] Wacom configured"
      exit 0
    else
      log_devices
      exit 1
    fi
    ;;
esac
