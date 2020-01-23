////////////////////////////
//
// Feedback Report System
//
////////////////////////////

/client/var/tfbsfr = 0

/client/verb/feedbacksolution()
	set name = " ❗ Обратная связь"
	set category = "ОСОБЕННОЕ"

	if(tfbsfr >= 3)
		to_chat(src, "Превышен лимит фидбека. Вы уже постарались, спасибо.", confidential = TRUE)
		return

	tfbsfr++

	SSblackbox.record_feedback("tally", "feedbacks_send", 1, "Feedback") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	feedback_send(src)


/client/proc/feedback_send(src)

	var/list/message = list()

	message["head"] = input(src,"Message:", "Придумайте название вашему запросу") as message|null
	message["content"] = input(src,"Message:", "Распишите ваш запрос в свободной форме") as message|null

	message["head"] = trim(message["head"])
	message["content"] = trim(message["content"])

	if(!message["head"] || !message["content"])
		to_chat(src, "Подумайте.", confidential = TRUE)
		return

	var/formattedmessage = "Header: [message["head"]]```[message["content"]]```Coords: [AREACOORD(usr)] [ckey]"

	text2file(formattedmessage, "data/feedbacksystem.log")

	to_chat(src, "Ваше сообщение: \"[message["head"]]\"\n\"[message["content"]]\"\n было доставлено. Благодарим вас за помощь.", confidential = TRUE)
