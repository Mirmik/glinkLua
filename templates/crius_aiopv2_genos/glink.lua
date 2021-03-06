print(text.green("Script Start"))

local files = find.findInTree("../genos", ".*.gll$", ".*HIDE.*")
script:evalFile(files, _ENV)

ruller = CXXDeclarativeRuller.new{
	buildutils = { 
		CXX = "avr-g++", 
		CC = "avr-gcc", 
		LD = "avr-ld", 
	},
	--weakRecompile = "noscript",
	optimization = "-O2",
	
	standart = {
		cxx = "-std=gnu++14",
		cc = "-std=gnu11",
	},
	
	flags = {
		cc = "",
		cxx = "-fno-rtti",
		ld = "-nostdinc -nostartfiles",
		allcc = "-nostdlib -lgcc -lm -mmcu=atmega2560 -DF_CPU=16000000 -Wl,--gc-sections -fdata-sections -ffunction-sections"
	},
	
	builddir = "./build"
}

Module("main", {
	sources = {
		cxx = "main.cpp",
	},

	includePaths = ".",
	
	modules = {
		{name = "cxx"},

		{name = "genos.dprint", impl = "diag"},
		{name = "genos.diag", impl = "impl"},
		
		{name = "genos.irqtbl"},
		
		--{name = "genos.arch.atmega2560"},
		--{name = "genos.board.arduino_mega"},

		--{name = "genos.fs.chardev", impl = "cxx"},
		--{name = "genos.arch.atmega2560.drivers.usart", impl = "cxx"},

		{name = "genos.libc"},
	},

	includeModules = {
		{name = "genos.include"},
		{name = "genos.include.libc",},
		{name = "genos.include.arch.atmega2560"},
		{name = "genos.include.board.crius"},
	},
})

local ret = ruller:standartAssemble("main", {
	target = "target",
	targetdir = "./build",
	assembletype = "application"
})

if not (ret) then print(text.yellow("Nothing to do")) end