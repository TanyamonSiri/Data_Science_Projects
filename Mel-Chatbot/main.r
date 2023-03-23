## main.r
# import library
library(glue)

## Text, line, space
M <- "Mel🐻:"
M <- glue("{M}")
M2 <- "🐻"
M2 <- glue("{M2}")
Y <- "You👨: "
Y1 <- ":You👨"
Y2 <- "👨"
Y <- glue("{Y}") 
Y1 <- glue("{Y1}") 
Y2 <- glue("{Y2}")
l <- "--------------------------------------------------------------\n"
l <- glue("{l}")
## Respond
res <- c("No problem!","Let's goo!💃🚀","Good choice!","Awesome!","Got it!")
exit <- c("See you next time buddy💖 ", 
                 "Alright! Have a nice day😊 ","Goodbyee, enjoy your dayy!!","Okie~ ",
                 "Have a good day! Mel will enjoy this fried chicken while waiting🍗", "Enjoying this chatbot? Feel free to leave a comment 🥳🌼")




## main menu
glue("{M} Hello!👋 Good to see you. Welcome to my home page. My name is Mel🐻✨ I'm a chatbot created to support you💖 Check for my services below.")
cat(l)


while (TRUE) {
  cat("\n")
  cat(glue("{M} So, what can I help you with today? "))
  cat("\n\n")
  cat(">> type '1': Hungry? Check for 'Thai food choosing' chatbot")
  cat("\n")
  cat(">> type '2': Looking for something to pass the time? Let's play 'Rock Paper Scissors' mini game with Mel👑🎈")
  cat("\n")
  cat(">> type 'exit': Ready to call it a day?")
  cat("\n")
  cat(Y ) #user input
  choice <- readLines("stdin", 1)
  if (choice == "1") {
    cat(glue("{M} {sample(res,1)} Wan nee kin rai dee naaa?"),"\n")
    source("chatbot.r")
  } else if (choice == "2") {
    cat(glue("{M} {sample(res,1)} Rock Paper Scissors~"), "\n")
    source("RPS_game.r")
  } else if (choice == "exit") { 
    cat(glue("{M} {sample(exit,1)}"), "\n")
    break }
  else {
      cat(glue("{M} Sorry! this command is not available in Mel database please type '1' or '2' to access the service"))
  } 
  
}
