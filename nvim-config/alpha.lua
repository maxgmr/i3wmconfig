local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	vim.notify("ERROR: Failed to load alpha.")
	return
end
local theme_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not theme_ok then
	vim.notify("ERROR: Failed to load alpha dashboard theme.")
end

math.randomseed(os.time())

local headers = {
	{
		[[░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░ ]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
		[[░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
	},
	{
		[[                                      .-'''-.                                             ]],
		[[                                     '   _    \                                           ]],
		[[   _..._           __.....__       /   /` '.   \   .----.     .----. .--.  __  __   ___   ]],
		[[ .'     '.     .-''         '.    .   |     \  '    \    \   /    /  |__| |  |/  `.'   `. ]],
		[[.   .-.   .   /     .-''"'-.  `.  |   '      |  '    '   '. /'   /   .--. |   .-.  .-.   ']],
		[[|  '   '  |  /     /________\   \ \    \     / /     |    |'    /    |  | |  |  |  |  |  |]],
		[[|  |   |  |  |                  |  `.   ` ..' /      |    ||    |    |  | |  |  |  |  |  |]],
		[[|  |   |  |  \    .-------------'     '-...-'`       '.   `'   .'    |  | |  |  |  |  |  |]],
		[[|  |   |  |   \    '-.____...---.                     \        /     |  | |  |  |  |  |  |]],
		[[|  |   |  |    `.             .'                       \      /      |__| |__|  |__|  |__|]],
		[[|  |   |  |      `''-...... -'                          '----'                            ]],
		[[|  |   |  |                                                                               ]],
		[['--'   '--'                                                                               ]],
	},
	{
		[[  _   _     U _____ u    U  ___ u  __     __                   __  __  ]],
		[[ | \ |"|    \| ___"|/     \/"_ \/  \ \   /"/u       ___      U|' \/ '|u]],
		[[<|  \| |>    |  _|"       | | | |   \ \ / //       |_"_|     \| |\/| |/]],
		[[U| |\  |u    | |___   .-,_| |_| |   /\ V /_,-.      | |       | |  | | ]],
		[[ |_| \_|     |_____|   \_)-\___/   U  \_/-(_/     U/| |\u     |_|  |_| ]],
		[[ ||   \\,-.  <<   >>        \\       //        .-,_|___|_,-. <<,-,,-.  ]],
		[[ (_")  (_/  (__) (__)      (__)     (__)        \_)-' '-(_/   (./  \.) ]],
	},
	{
		[[     ___           ___           ___           ___                       ___     ]],
		[[    /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
		[[   /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
		[[  /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
		[[ /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
		[[/:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
		[[\/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
		[[    |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
		[[    |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
		[[    /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
		[[    \/__/         \/__/         \/__/                                   \/__/    ]],
	},
	{
		[[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
		[[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
		[[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
		[[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
		[[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
		[[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
		[[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
		[[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
		[[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
		[[                                ░                  ]],
	},
	{
		[[                                         .-.                 ]],
		[[ ___ .-.     .--.     .--.    ___  ___  ( __)  ___ .-. .-.   ]],
		[[(   )   \   /    \   /    \  (   )(   ) (''") (   )   '   \  ]],
		[[ |  .-. .  |  .-. ; |  .-. ;  | |  | |   | |   |  .-.  .-. ; ]],
		[[ | |  | |  |  | | | | |  | |  | |  | |   | |   | |  | |  | | ]],
		[[ | |  | |  |  |/  | | |  | |  | |  | |   | |   | |  | |  | | ]],
		[[ | |  | |  |  ' _.' | |  | |  | |  | |   | |   | |  | |  | | ]],
		[[ | |  | |  |  .'.-. | '  | |  ' '  ; '   | |   | |  | |  | | ]],
		[[ | |  | |  '  `-' / '  `-' /   \ `' /    | |   | |  | |  | | ]],
		[[(___)(___)  `.__.'   `.__.'     '_.'    (___) (___)(___)(___)]],
	},
	{
		[[ ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ]],
		[[•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪]],
		[[▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·]],
		[[██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌]],
		[[▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀]],
	},
	{
		[[ ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄        ▄▄  ▄▄       ▄▄ ]],
		[[▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░▌      ▐░░▌▐░░▌     ▐░░▌]],
		[[▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌     ▐░▐░▌▐░▌░▌   ▐░▐░▌]],
		[[▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌▐░▌ ▐░▌▐░▌]],
		[[▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌   ▐░▌ ▐░▌▐░▌ ▐░▐░▌ ▐░▌]],
		[[▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌]],
		[[▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌ ▐░▌   ▐░▌▐░▌   ▀   ▐░▌]],
		[[▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌       ▐░▌]],
		[[▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░ ░▌     ▐░▌▐░▌       ▐░▌]],
		[[▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░▌      ▐░▌▐░▌       ▐░▌]],
		[[ ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀        ▀  ▀         ▀ ]],
	},
}

local function centre_align(tbl)
	vim.validate({
		tbl = { tbl, "table" },
	})
	local max_len = 0
	for i = 1, #tbl do
		if #tbl[i] > max_len then
			max_len = #tbl[i]
		end
	end
	for i = 1, #tbl do
		local diff = max_len - #tbl[i]
		tbl[i] = string.rep(" ", math.floor(diff / 2)) .. tbl[i]
	end
	return tbl
end

local footers = {
	centre_align({
		[[]],
		[[]],
		[[Love is patient;]],
		[[love is kind;]],
		[[love is not envious or boastful or arrogant or rude.]],
		[[It does not insist on its own way;]],
		[[it is not irritable or resentful;]],
		[[it does not rejoice in wrongdoing, but rejoices in the truth.]],
		[[It bears all things,]],
		[[believes all things,]],
		[[hopes all things,]],
		[[endures all things.]],
		[[- 1 Corinthians 13:4-7]],
	}),
	centre_align({
		[[]],
		[[]],
		[[So whenever you give alms, do not sound a trumpet before you,]],
		[[as the hypocrites do in the synagogues and in the streets,]],
		[[so that they may be praised by others.]],
		[[Truly I tell you, they have received their reward.]],
		[[But when you give alms, do not let your left hand know what]],
		[[your right hand is doing, so that your alms may be done in secret;]],
		[[and your Father who sees in secret will reward you.]],
		[[- Matthew 6:2-4]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Have you not known? Have you not heard?]],
		[[The LORD is the everlasting God,]],
		[[the Creator of the ends of the earth.]],
		[[He does not faint or grow weary;]],
		[[his understanding is unsearchable.]],
		[[He gives power to the faint,]],
		[[and strengthens the powerless.]],
		[[Even youths will faint and be weary,]],
		[[and the young will fall exhausted;]],
		[[but those who wait for the LORD shall renew their strength,]],
		[[they shall mount up with wings like eagles,]],
		[[they shall run and not be weary,]],
		[[they shall walk and not faint.]],
		[[- Isaiah 40:28-35]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Do not fear, for I am with you,]],
		[[do not be afraid, for I am your God;]],
		[[I will strengthen you, I will help you,]],
		[[I will uphold you with my victorious right hand.]],
		[[- Isaiah 41:10]],
	}),
	centre_align({
		[[]],
		[[]],
		[[I know that whatever God does endures for ever;]],
		[[nothing can be added to it, nor anything taken from it;]],
		[[God has done this, so that all should stand in awe before him.]],
		[[That which is, already has been; ]],
		[[that which is to be, already is;]],
		[[and God seeks out what has gone by.]],
		[[- Ecclesiastes 3:14-15]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Let the heavens be glad, and let the earth rejoice;]],
		[[let the sea roar, and all that fills it;]],
		[[let the field exult, and everything in it.]],
		[[Then shall all the trees of the forest sing for joy]],
		[[before the Lord; for he is coming,]],
		[[for he is coming to judge the earth.]],
		[[He will judge the world with righteousness,]],
		[[and the peoples with his truth.]],
		[[- Psalms 96:12-13]],
	}),
	centre_align({
		[[]],
		[[]],
		[[The steadfast love of the LORD never ceases,]],
		[[his mercies never come to an end;]],
		[[they are new every morning;]],
		[[great is your faithfulness.]],
		[[- Lamentations 3:22-23]],
	}),
	centre_align({
		[[]],
		[[]],
		[[For God so loved the world that he gave his only Son, so that everyone]],
		[[who believes in him may not perish but may have eternal life.]],
		[[- John 3:16]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Indeed, rarely will anyone die for a righteous person—though perhaps]],
		[[for a good person someone might actually dare to die.]],
		[[But God proves his love for us in that while we still were sinners]],
		[[Christ died for us. ]],
		[[- Romans 5:7-8]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Do not be conformed to this world,]],
		[[but be transformed by the renewing of your minds,]],
		[[so that you may discern what is the will of God—]],
		[[what is good and acceptable and perfect.]],
		[[- Romans 12:2]],
	}),
	centre_align({
		[[]],
		[[]],
		[[Come to me, all you that are weary and are carrying heavy burdens,]],
		[[and I will give you rest. ]],
		[[- Matthew 11:28]],
	}),
	centre_align({
		[[]],
		[[]],
		[[In the beginning when God created the heavens and the earth,]],
		[[the earth was a formless void and darkness covered the face of the deep,]],
		[[while a wind from God swept over the face of the waters.]],
		[[Then God said, ‘Let there be light’; and there was light. ]],
		[[- Genesis 1:1-3]],
	}),
	{ [[]], [[]], "~ Max s Michayla ~" },
}

dashboard.section.header.val = headers[math.random(#headers)]
dashboard.section.header.opts = {
	hl = "GruvboxBlue",
	position = "center",
}

dashboard.section.buttons.val = {
	dashboard.button("o", "  > Open Current Directory", ":e .<CR>"),
	dashboard.button("f", "  > Find File", ":cd $HOME | Telescope find_files<CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("q", "󰩈  > Quit", ":qa<CR>"),
}

dashboard.section.footer.val = footers[math.random(#footers)]
dashboard.section.footer.opts = {
	hl = "GruvboxPurple",
	position = "center",
}

-- pass config to alpha
alpha.setup(dashboard.opts)
-- disable folding for alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
