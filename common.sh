log_file=/tmp/expense.log


download_and_extract(){

  echo Download $component code
  curl -s -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip >> $log_file
  #echo $?
  stat_check

  echo Exract $component code
  unzip /tmp/${component}.zip >> $log_file
  #echo $?
  stat_check
}

stat_check(){

  if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
    exit
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 1
  fi
}