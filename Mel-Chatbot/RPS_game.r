## Homewoek02
## Rock Paper Scissors game
## or Pao Ying Chub game in Thai

cat(M, "Just a second! I'm loading some libraries📦")
cat("\n")
cat(M, "Loading.....")
library(dplyr)
## create option
options <- c("1", "2", "3")
pyc <- list( "1" = "Rock","2" = "Paper", "3" = "Scissors")
pyc_icon <- list("1"= "✊", "2" = "🖐️", "3" = "✌️")     
## Mel respond
respond <- list(
  cheerful = c("Good luck!", "Let's go!!", "This match gonna be fun!","💖💖💖"),
  cheeky = c("(smirk)","😜","Noob...oh sorry I mean nice try", "Sorry but this is my victory!","It's okay. Sometimes we lose, sometimes we win😛","👑💖"),
  excite = c("Oh, you're so good!", "One more round!🔥","Lucky....","🔥🔥🔥",
             "You're just lucky this time😤", "Let's do it again!", 
             "Good job! Here's your trophy 🏆"),
  bye = c("Let's play together next time✌","Have to go now? Okie",
          "Alright, btw are you hungry? Mel also has food selection service! go back to main menu and check for >> 'Wan nee kin rai dee naaa' chatbot",
          "Thank you for playing with Mel💖")
)


## Game Setting: Introduction and Responses
mel_PYC_game <- function() {
  cat(l)
  cat(M,"Alright! Let's play 'Rock Paper Scissors' game together!✊x✋x✌️\n") 
  while (TRUE) {
    cat("\n")
    cat(l)
    cat("User Instruction:\n")
    cat(">> Type '1' if you're ready for the game 🌈\n")
    cat(">> Type 'back' to go back to the main menu\n")
    cat(l)
    
    ## calculation
    # create factor to store the scores
    user_score <- 0
    mel_score <- 0
    round <-0
 
    round_no <- c()
    user <- c()
    mel <- c()
    
    # create blank dataframe with column name
    #df1 <- data.frame(Round = numeric(),
                      #  User = numeric(),
                       # Mel = numeric())
    
    
    ## stop
    stop <- FALSE
    
    ## main body
    cat(Y ) ## user input
    user_input <- readLines("stdin",1) #replit_version
    #user_input <- readline()
    if (user_input == 'back' ) {
      stop <- TRUE
      cat(M,sample(respond$bye,1),"\n")
      break
    } 
    else if (user_input == 1) {
      cat(M,sample(respond$cheerful,1))
      cat("\n")
      cat(M,"Type 'stop' if you want to stop playing😥")
      while (TRUE) {
        cat("\n")
        round <- round +1
        cat(l)
        cat(M,"Round",round,"start!","\n")
        cat(">> Rock:'1' x Paper:'2' x Scissors:'3' \n")
        cat(Y ) ##user input
        user_select <- readLines("stdin",1)
        #user_select <- readline()
        mel_select <- sample(options,1)
        if (user_select == 'stop') {
          cat(l)
          cat(M,sample(respond$bye,1),"\n\n")

          df1 <- data.frame(round_no,user,mel)
          colnames(df1) <- c("Round","User_Point","Mel_Point")
          df1 <- df1 %>% 
            mutate(Result = case_when(
              Mel_Point == User_Point ~ "Draw",
              Mel_Point > User_Point ~ "Mel",
              Mel_Point < User_Point ~ "You"
            ) )
          
          draw <- nrow(df1[df1$Result  == 'Draw', ])
          mel_score <- nrow(df1[df1$Result  == 'Mel', ])
          user_score <- nrow(df1[df1$Result  == 'You', ])
          cat("*** Match Summary ***","\n\n")
          print(df1,row.names=FALSE)
          cat("\n")
          cat(">> Total round we've played: ",round-1,"\n>> Total score:","Draw x",draw,", Mel🐻's Win x",mel_score,
              ", You👨's Win x",user_score,"\n\n")
          
          cat("\n")
          if (mel_score> user_score) {
            cat(M,"You lose!",sample(respond$cheeky,1))
          }
          else if (mel_score< user_score) {
            cat(M,"You win!",sample(respond$excite,1))
          }
          else {
            cat(M,"Tie!",sample(respond$excite,1))
          }
          cat("\n")
          
          break
        }
        else if (user_select %in% options) {
          dummy <- as.numeric(user_select)-as.numeric(mel_select)
          user_index <- which(names(pyc) == user_select)
          mel_index <- which(names(pyc) == mel_select)
          
          cat(">>",M,pyc[[mel_index]], pyc_icon[[mel_index]]," VS",pyc_icon[[user_index]]," ", pyc[[user_index]],Y1,"<< \n")
          if (as.numeric(mel_select) < as.numeric(user_select))  {
            if (abs(dummy) == 1) {
              user_score <- 1
              mel_score <- 0
              cat(M,"You win!",sample(respond$excite,1))
            } else {
              mel_score <- 1
              user_score <- 0
              cat(M,"I win!",sample(respond$cheeky,1))
            }
            round_no <- append(round_no, round)
            user <- append(user, user_score)
            mel <- append(mel, mel_score)
            #cat(round_no,"\n",user,"\n",mel)
          }
          else if (as.numeric(mel_select) > as.numeric(user_select)) {
            if (abs(dummy) != 1) {
              user_score <- 1
              mel_score <- 0
              cat(M,"You win!",sample(respond$excite,1))
            } else {
              mel_score <- 1
              user_score <- 0
              cat(M,"I win!",sample(respond$cheeky,1))
            }
            round_no <- append(round_no, round)
            user <- append(user, user_score)
            mel <- append(mel, mel_score)
            #cat(round_no,"\n",user,"\n",mel)
          }else {
            user_score <- 1
            mel_score <- 1
            cat(M,"Draw!",sample(respond$excite,1))
            round_no <- append(round_no, round)
            user <- append(user, user_score)
            mel <- append(mel, mel_score)
            #cat(round_no,"\n",user,"\n",mel)
            }
          
        } else {
          cat(M,"Choose one from Rock:'1', Paper:'2', Scissors:'3'")
          cat("\n")
          cat(M,"For example: type '2' for Paper or 'stop' if you want to stop playing ")
          round <- round-1
        }
      }
      
    } else {cat(M,"Sorry but this command is not available in Mel database")}
  }
}
mel_PYC_game()