//How often should a message be printed to the chatbox?
local timeToSend = 60

local adverthints = {
	"Place your adverts or hints into this table!",
	"Be sure to keep all the messages within quotations",
	"Also be sure to add a comma at the end of the quote",
	"You can add as many adverts/hints as you wish"
}


timer.Create("chatadverts", timeToSend, 0, function()
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint(adverthints[math.random(1,#adverthints)])
	end
end)