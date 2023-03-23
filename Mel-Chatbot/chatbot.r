## Wan nee kin rai dee naaa?
## R Programming 
## Homework01 

## Text, line, space
command = "['1':guideline, '2': For Food!🍕, '3':just visiting, 'back': main menu]"
Meat_choice <- "Pork🐷|Muknop🥩|Chicken🐔|Egg🥚|Fish🐟|Shrimp🦐"
space <- "              "
space2 <- "    "

## create function to return menus based on user input
kin_rai_dee_na <- function(your_meat,meal="rice"){
  your_meat <- toupper(your_meat)
  meal <- toupper(meal)
  rice_noodle <- c("RICE","NOODLE")
  meat <- c("PORK","MUKNOP","CHICKEN","EGG",
            "FISH","SHRIMP"
            )
  ADDON <- "'ไข่ดาว🍳','ไข่เจียว', 'ไข่เยี่ยวม้า','ไข่ต้ม'"
  
  rice_menus <- list(
    PORK = c("หมูผัดน้ำมันหอยราดข้าว","ข้าวหมูผัดพริกเผา" ,"ข้าวหน้าหมูเกาหลี"
             ,"ข้าวหมูผัดพริกแกง","ผัดเปรี้ยวหวานหมูราดข้าว","ผัดผักรวมหมูราดข้าว",
             "หมูสับผัดพริกเกลือราดข้าว","ราดหน้าหมูนุ่ม","ต้มเลือดหมู+ข้าว","ข้าวต้มหมู",
             "แกงจืดเต้าหู้หมูสับ+ข้าว","ข้าวหมูกะหล่ำปลีผัดน้ำปลา","หน่ำเลียบหมูสับราดข้าว",
             "กะเพราวุ้นเส้นหมูสับราดข้าว","ข้าวขาหมู"),
    MUKNOP = c("คะน้าหมูกรอบราดข้าว","หมูกรอบผัดพริกเผาราดข้าว",
               "หมูกรอบผัดพริกเกลือราดข้าว","ผัดผักบุ้งหมูกรอบราดข้าว"
               ,"หมูกรอบผัดฉ่าราดข้าว","กะเพราหมูกรอบราดข้าว","หมูกรอบผัดผงกระหรี่ราดข้าว"),
    CHICKEN = c("ไก่ผัดพริกเผาราดข้าว", "ไก่ผัดพริกหยวกราดข้าว",
                 "กะเพราไก่ราดข้าว","ไก่ผัดเม็ดมะม่วงราดข้าว","ต้มยำไก่ + ข้าว",
                 "ข้าวยำไก่แซ่บ"	,"ข้าวต้มไก่","ไก่ผัดขิงราดข้าว",
                 "ข้าวไก่ผัดพริกแกง","ข้าวไก่กระเทียม","กะเพราวุ้นเส้นไก่สับราดข้าว")  ,
    SHRIMP = c("ต้มยำกุ้ง + ข้าว","ข้าวต้มกุ้ง","กุ้งผัดพริกเกลือราดข้าว",
               "ผัดผักรวมกุ้งราดข้าว"),
    EGG = c("ข้าวไข่ข้น", "ข้าวไข่ข้นกุ้ง" , "ข้าวไข่ข้นแฮม", "ข้าวไข่ข้นหมูกรอบ",
            "ข้าวไข่เจียว", "ข้าวไข่เจียวหมูสับ","ไข่กระทะ","ข้าวกะเพราไข่เยี่ยวม้า","ข้าวผัดไข่",
            "แขนงผัดไข่ราดข้าว"),
    FISH = c("ข้าวต้มปลา","ข้าวผัดปลาสลิด","ข้าวราดปลาผัดฉ่า"
             ,"แขนงปลาเค็มราดข้าว","คะน้าปลาเค็มราดข้าว","ปลาผัดขิงราดข้าว"))
  noodle_menus <- list(
    MUKNOP = c("มาม่าขี้เมาหมูกรอบ","เส้นใหญ่ผัดซีอิ๊วหมูกรอบ" ,"สปาเกตตี้ผัดกะเพราหมูกรอบ","หมี่กระเฉดหมูกรอบ","วุ้นเส้นหมูกรอบคั่วพริกเกลือ","ก๋วยจั๊บน้ำข้นหมูกรอบ"),
    PORK = c("สปาเกตตี้ผัดขี้เมาหมู","มักกะโรนีขี้เมาหมู","มาม่าผัดหมูสับ","สุกี้น้ำหมู","สุกี้แห้งหมู","ผัดซีอิ๊ว","ผัดวุ้นเส้นหมูสับ","หมี่กระเฉดหมู","มาม่าขี้เมาหมู"),
    SHRIMP = c("ผัดไทยกุ้งสด","มาม่าขี้เมากุ้ง","ยำมาม่าใส่กุ้ง","สุกี้น้ำกุ้ง","สุกี้แห้งกุ้ง"),
    FISH = c("สุกี้น้ำปลา","สุกี้แห้งปลา"),
    CHICKEN = c("ก๋วยเตี๋ยวคั่วไก่","สุกี้น้ำไก่","สุกี้แห้งไก่","หมี่กระเฉดไก่"),
    EGG = c("มาม่าผัดไข่","สุกี้น้ำไม่ใส่เนื้อสัตว์","สุกี้แห้งไม่ใส่เนื้อสัตว์")
  )
  
  
  if (is.element(your_meat,meat) == FALSE) {
    return(1)
    
  } else if (is.element(meal,rice_noodle) == FALSE) {
    return(2)
    
  } else if (meal == "RICE"){
    meat_index <- which(names(rice_menus) == your_meat)
    if (your_meat=="EGG") {
      out <- glue("Here's your menu >> {sample(rice_menus[[meat_index]],1)}")
    } else{
      out <- c(glue("Here's your menu >> {sample(rice_menus[[meat_index]],1)} \n\n"),glue("Starving? Here're some add-on {ADDON}"))
    return(out)
    }
    
  } else if (meal == "NOODLE"){
    meat_index <- which(names(noodle_menus) == your_meat)
    out <- glue("Here is your menu >> {sample(noodle_menus[[meat_index]],1)}")
    return(out)
  }
  }


## chat bot to randomly select menu for user

mel_choose_food_bot <- function() {
  cat(l)
  cat(glue("{M} Hello again! Welcome to 'Wan nee kin rai dee naaa' chatbot"))
  cat("\n")
  cat(glue("{M} Mel is here to support and answer your simple but nerve-wracking question that you ask yourself daily (when you're hungry🍜)"),"\n")
  
  ## Mel proactive conversation
  comment <- list(
    mel_1 = c("Have a nice meal!!","Bon Appétit!",
              "Nice one eiei","Enjoyyy~","A fine choice😊"),
    mel_back = c("See you~ 💖 ", 
                 "Have a nice day🌈 ","...Don't leave me😥","Okie~ ",
                 "Goodbye! Always keep in mind that people who love to eat are always the best people🍉"),
    mel_ok = c("Okie Dokie","Okie","😆","Alright, don't forget that I'm here for you","Very well🥰","Have some time to spare? Let's play 'Rock Paper Scissors' mini game together"),
    mel_reask = c("Try again?","Change your mind? Let Mel help you!",
                  "Not satisfied? Would you like to try a new dish?")
  )
  
  ## control flow
  while (TRUE) {
    
    cat(l)
    cat("\n")
    cat(glue("{M} What're you here for today?"),"\n")
    cat(glue("{M} {command}"),"\n")
    cat(Y ) ## user input
    user_start <- readLines( "stdin",1)
    if (user_start == "back" ) {
      cat(glue("{M} {sample(comment$mel_back,1)} \n"))
      break
    }
    
    else if (user_start == 1 ) {
      cat(glue("{M} Here's our guideline\n"),"\n")
      cat("      >> Step1: Select your meat.","\n")
      cat(glue("{space}: {Meat_choice}"),"\n")
      cat("      >> Step2: Select your preference. Rice🍚 or Noodle🍜? \n")
      cat(glue("{M} Good choices!"),"\n")
      cat(glue("{M} Wait a second, Mel will select your special dish💖\n"),"\n")
      cat(l)
      cat(glue("{M} You good? Type '2' to start explore now\n"),"\n")
    } else if (user_start == 2) {
      while(TRUE){
        
        cat(glue("{Y} Wan nee kin rai dee naaa?"),"\n")
        cat(glue("{space2}Step1: Select your meat","\n", "{space2}{Meat_choice}"),"\n")
        cat(Y )
        user_meat <- readLines("stdin",1)
        cat(glue("{space2}Step2: Rice🍚 or Noodle🍜? "),"\n")
        cat(Y )
        rice_or_noodle <- readLines("stdin",1)
        answer <- kin_rai_dee_na(user_meat,rice_or_noodle)
        if (is.numeric(answer)== FALSE) {
          
          cat(glue("{M} {answer}"),"\n")
          cat(glue("{M} {sample(comment$mel_1,1)}\n"),"\n")
          cat(glue("{M} {sample(comment$mel_reask,1)} [Y/N] ?"),"\n")
          cat(Y )
          user_stop <- readLines("stdin",1)
          user_stop <- tolower(user_stop)
          if (user_stop == "n") {
            cat(glue("{M} {sample(comment$mel_ok,1)}"),"\n")
            break
          }
          else if ( user_stop == "exit" | user_stop == "back" ) {
            
            break
          }
          
        }
        
        else if (answer == 1) {
          cat(glue("{M} Sorry! {toupper(user_meat)} is not available Mel database😥 Please select new one\n"),"\n")
        }
        else if (answer == 2) {
          cat(glue("{M} Sorry! {toupper(rice_or_noodle)} is not available Mel database😥 Please select new one\n"),"\n")
        }
      
        }
      
    }
      else if (user_start == 3) {
      cat(glue("{M} {sample(comment$mel_ok,1)}"),"\n")
    }
  
  }
  
}
mel_choose_food_bot()