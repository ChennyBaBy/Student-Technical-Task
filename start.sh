#!/bin/bash
my_dir="$(dirname "$0")"

imgcat () {
	"$my_dir/imgcat.sh" $1
}
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

winningNumbers=(2 22 29 30 36 53 58)

function initialise {
    printf "Before we begin, I have a few questions..\n";
    read -r -p "Are you using iTerm 2 & wearing your headphones? [y/n]  " response
    case $response in
        [yY][eE][sS]|[yY])
            printf "\033c"
            intro
            get_tickets
            start_lotto
            results_please
            exit 0
            ;;
        *)
            printf 'How Tragic...  🙀 come back when you have got them '; exit 0;
            ;;
    esac
}

function intro {
  printf "\n \n \n";
  echo -e "                              ${YELLOW}__...---\"\"\"\"\"\"---...__${NC}";
  echo -e "                 ${RED}.:::::.${NC}   _.-'                      ${YELLOW}'-._${NC}";
  echo -e "            ${RED}.::::::::::::::::'${NC}   ^^      ,              ${YELLOW}'-.${NC}";
  echo -e "       ${RED}.  .:::''''::::::::'${NC}   ,        _/(_       ^^       ${YELLOW}'.${NC}";
  echo -e "         ${RED}':::'${NC}      .'       _/(_       {\\               ,   ${YELLOW}'.${NC}";
  echo -e "                   ${YELLOW}/${NC}         {\\        /;_)            _/(_    ${YELLOW}'${NC}";
  echo -e "                  ${YELLOW}/${NC}   ,      /;_)    =='/ <===<<<       {\\      ${YELLOW}'${NC}";
  echo -e "                 ${YELLOW}/${NC}  _/(_  =='/ <===<<<  \__\       ,    /;_)      ${YELLOW}'${NC}";
  echo -e "                ${YELLOW}/${NC}   {\\      \__\      , ``       _/(_=='/ <===<<<  ${YELLOW}' ${NC}";
  echo -e "              ========================================================== ";
  echo -e "              👻    Welcome to the Halloween 2016 ${RED}Lottery Special${NC}     👻  ";
  echo "              ========================================================== ";
  printf "\n \n \n";
  afplay ./bgm.mp3 &
}

function get_tickets {
  printf "💀  Let's pick your lucky numbers! Good Luck! (From 1 - 59)  💀\n\n";

  read -p "What is your 1st number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[0]=${number};
  else exit_angrly;
  fi

  printf "\n"
  read -p "What is your 2nd number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[1]=${number};
  else exit_angrly;
  fi

  printf "\n"
  read -p "What is your 3rd number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[2]=${number};
  else exit_angrly;
  fi

  printf "\n"
  read -p "What is your 4th number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[3]=${number};
  else exit_angrly;
  fi

  printf "\n"
  read -p "What is your 5th number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[4]=${number};
  else exit_angrly;
  fi

  printf "\n"
  read -p "What is your last number: " number
  if [ ${number} -ge 0 -a ${number} -le 60 ]; then
    userNumbers[5]=${number};
  else exit_angrly;
  fi

  printf "\n"
  echo "You have chosen:"
  echo ${userNumbers[*]}
}

function exit_angrly {
  echo "\n I said pick from 1 - 59! Don't try to break my code! Go Away!!  😤" & killall afplay && exit 1;
}

function print_lotto_ball {
  imgcat ./numbers/lotto$1.png
}

function gen_numbers {
  printf "\n Rolling:";
  printf "\n"
  sleep 12s

  printf ""
  print_lotto_ball ${winningNumbers[1]}

  printf "\n"
  sleep 7.5s
  print_lotto_ball ${winningNumbers[3]}
  printf "\n"
  sleep 7s
  print_lotto_ball ${winningNumbers[4]}
  printf "\n"
  sleep 7s
  print_lotto_ball ${winningNumbers[6]}
  printf "\n"
  sleep 7s
  print_lotto_ball ${winningNumbers[2]}
  printf "\n"
  sleep 7s
  print_lotto_ball ${winningNumbers[0]}
  printf "\n"
  sleep 8.5s
  print_lotto_ball ${winningNumbers[5]}
  printf "\n"

  sleep 5s

  printf "Here are the numbers again: \n"
  echo ${winningNumbers[@]}

  sleep 14s
}

function start_lotto {
  killall afplay &> /dev/null;
  imgcat ./giflottery.gif & afplay ./lottodrawsound.mov & gen_numbers;
}

function results_please {
  result=0
  for ((i=0;i < ${#winningNumbers[@]};i++)) {
    currentNumber=${winningNumbers[$i]}

    for ((j=0;j < ${#userNumbers[@]};j++)) {
      if [ ${userNumbers[$j]} -eq $currentNumber ]; then
        result=$(($result+1))
      fi
    }
  }

  if [ $result -eq "0" ]; then
    reply='That sucks, Good bye!  👋'
  elif [ $result -lt "3" ]; then
    reply='You win nothing!'
  elif [ $result -lt "6" ]; then
    reply='Well Done!!'
  elif [ $result -eq "6" ]; then
    reply='🎉  We have a winner!! 😝 All Number Matches!!   🎉'
  fi

  echo "==================================================="
  imgcat ./shywinner.gif
  echo "==================================================="
  printf "It looks like you have $result matches. \n\n"
  echo $reply
  printf "\nThanks for playing!!!\n"
  echo "==================================================="
}



########################################################
# App Kick Off
########################################################

initialise
