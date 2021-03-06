library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package Monitor is
	
	--constant N	: integer := 512;
	constant M	: integer := 32;
	--type in_data is array (0 to N-1) of std_logic_vector(M-1 downto 0);
	
	constant N_sort	: integer := 128;
	type in_data is array (0 to 8000-1) of  character;

	function BitsNecessary(Number : natural) return natural;

--------------------------------------------------------------------------------
--   MONITOR 0   -----------   MONITOR 1   -----------   MONITOR 2   -----------
--------------------------------------------------------------------------------
-- [640x480 @59Hz]        -- [640x480 @60Hz]        -- [640x480 @72Hz]        --
-- PIXEL CLK  = 25000     -- PIXEL CLK  = 25170     -- PIXEL CLK  = 31500     --
-- H DISP     = 640       -- H DISP     = 640       -- H DISP     = 640       --
-- H BPORCH   = 48        -- H BPORCH   = 48        -- H BPORCH   = 128       --
-- H FPORCH   = 16        -- H FPORCH   = 16        -- H FPORCH   = 24        --
-- H SYNC     = 96        -- H SYNC     = 96        -- H SYNC     = 40        --
-- H SYNC POL = Negative  -- H SYNC POL = Negative  -- H SYNC POL = Negative  --
-- V DISP     = 480       -- V DISP     = 480       -- V DISP     = 480       --
-- V BPORCH   = 29        -- V BPORCH   = 31        -- V BPORCH   = 28        --
-- V FPORCH   = 10        -- V FPORCH   = 11        -- V FPORCH   = 09        --
-- V SYNC     = 2         -- V SYNC     = 2         -- V SYNC     = 3         --
-- V SYNC POL = Negative  -- V SYNC POL = Negative  -- V SYNC POL = Negative  --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--   MONITOR 3   -----------   MONITOR 4   -----------   MONITOR 5   -----------
--------------------------------------------------------------------------------
-- [640x480 @75Hz]        -- [640x480 @85Hz]        -- [800x600 @56Hz]        --
-- PIXEL CLK  = 31500     -- PIXEL CLK  = 36000     -- PIXEL CLK  = 36000     --
-- H DISP     = 640       -- H DISP     = 640       -- H DISP     = 800       --
-- H BPORCH   = 48        -- H BPORCH   = 112       -- H BPORCH   = 128       --
-- H FPORCH   = 16        -- H FPORCH   = 32        -- H FPORCH   = 24        --
-- H SYNC     = 96        -- H SYNC     = 48        -- H SYNC     = 72        --
-- H SYNC POL = Negative  -- H SYNC POL = Negative  -- H SYNC POL = Positive  --
-- V DISP     = 480       -- V DISP     = 480       -- V DISP     = 600       --
-- V BPORCH   = 32        -- V BPORCH   = 25        -- V BPORCH   = 25        --
-- V FPORCH   = 11        -- V FPORCH   = 1         -- V FPORCH   = 1         --
-- V SYNC     = 2         -- V SYNC     = 3         -- V SYNC     = 3         --
-- V SYNC POL = Negative  -- V SYNC POL = Negative  -- V SYNC POL = Positive  --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--   MONITOR 6   -----------   MONITOR 7   -----------   MONITOR 8   -----------
--------------------------------------------------------------------------------
-- [800x600 @56Hz]        -- [800x600 @60Hz]        -- [800x600 @72Hz]        --
-- PIXEL CLK  = 38100     -- PIXEL CLK  = 40000     -- PIXEL CLK  = 50000     --
-- H DISP     = 800       -- H DISP     = 800       -- H DISP     = 800       --
-- H BPORCH   = 128       -- H BPORCH   = 88        -- H BPORCH   = 64        --
-- H FPORCH   = 32        -- H FPORCH   = 40        -- H FPORCH   = 56        --
-- H SYNC     = 128       -- H SYNC     = 128       -- H SYNC     = 120       --
-- H SYNC POL = Negative  -- H SYNC POL = Positive  -- H SYNC POL = Positive  --
-- V DISP     = 600       -- V DISP     = 600       -- V DISP     = 600       --
-- V BPORCH   = 14        -- V BPORCH   = 23        -- V BPORCH   = 23        --
-- V FPORCH   = 1         -- V FPORCH   = 1         -- V FPORCH   = 37        --
-- V SYNC     = 4         -- V SYNC     = 4         -- V SYNC     = 6         --
-- V SYNC POL = Negative  -- V SYNC POL = Positive  -- V SYNC POL = Positive  --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--   MONITOR 9   -----------   MONITOR 10  -----------   MONITOR 11  -----------
--------------------------------------------------------------------------------
-- [800x600 @75Hz]        -- [800x600 @85Hz]        -- [1024x768 @60Hz]       --
-- PIXEL CLK  = 49500     -- PIXEL CLK  = 56250     -- PIXEL CLK  = 65000     --
-- H DISP     = 800       -- H DISP     = 800       -- H DISP     = 1024      --
-- H BPORCH   = 160       -- H BPORCH   = 152       -- H BPORCH   = 160       --
-- H FPORCH   = 16        -- H FPORCH   = 32        -- H FPORCH   = 24        --
-- H SYNC     = 80        -- H SYNC     = 64        -- H SYNC     = 136       --
-- H SYNC POL = Positive  -- H SYNC POL = Positive  -- H SYNC POL = Negative  --
-- V DISP     = 600       -- V DISP     = 600       -- V DISP     = 768       --
-- V BPORCH   = 21        -- V BPORCH   = 27        -- V BPORCH   = 29        --
-- V FPORCH   = 1         -- V FPORCH   = 1         -- V FPORCH   = 3         --
-- V SYNC     = 2         -- V SYNC     = 3         -- V SYNC     = 6         --
-- V SYNC POL = Positive  -- V SYNC POL = Positive  -- V SYNC POL = Negative  --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--   MONITOR 12  -----------   MONITOR 13  -----------   MONITOR 14  -----------
--------------------------------------------------------------------------------
-- [1024x768 @70Hz]       -- [1024x768 @70Hz]       -- [1024x768 @75Hz]       --
-- PIXEL CLK  = 72000     -- PIXEL CLK  = 75000     -- PIXEL CLK  = 78750     --
-- H DISP     = 1024      -- H DISP     = 1024      -- H DISP     = 1024      --
-- H BPORCH   = 88        -- H BPORCH   = 144       -- H BPORCH   = 176       --
-- H FPORCH   = 32        -- H FPORCH   = 24        -- H FPORCH   = 16        --
-- H SYNC     = 136       -- H SYNC     = 136       -- H SYNC     = 96        --
-- H SYNC POL = Negative  -- H SYNC POL = Negative  -- H SYNC POL = Positive  --
-- V DISP     = 768       -- V DISP     = 768       -- V DISP     = 768       --
-- V BPORCH   = 30        -- V BPORCH   = 29        -- V BPORCH   = 28        --
-- V FPORCH   = 2         -- V FPORCH   = 3         -- V FPORCH   = 1         --
-- V SYNC     = 6         -- V SYNC     = 6         -- V SYNC     = 3         --
-- V SYNC POL = Negative  -- V SYNC POL = Negative  -- V SYNC POL = Positive  --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--   MONITOR 15  -----------   MONITOR 16  -----------   MONITOR 17  -----------
--------------------------------------------------------------------------------
-- [1024x768 @85Hz]       -- [1152x864 @75Hz]       -- [1280x1024 @60Hz]      --
-- PIXEL CLK  = 94500     -- PIXEL CLK  = 108000    -- PIXEL CLK  = 108000    --
-- H DISP     = 1024      -- H DISP     = 1152      -- H DISP     = 1280      --
-- H BPORCH   = 208       -- H BPORCH   = 256       -- H BPORCH   = 248       --
-- H FPORCH   = 48        -- H FPORCH   = 64        -- H FPORCH   = 48        --
-- H SYNC     = 96        -- H SYNC     = 128       -- H SYNC     = 112       --
-- H SYNC POL = Positive  -- H SYNC POL = Positive  -- H SYNC POL = Positive  --
-- V DISP     = 768       -- V DISP     = 864       -- V DISP     = 1024      --
-- V BPORCH   = 36        -- V BPORCH   = 32        -- V BPORCH   = 38        --
-- V FPORCH   = 1         -- V FPORCH   = 1         -- V FPORCH   = 1         --
-- V SYNC     = 3         -- V SYNC     = 3         -- V SYNC     = 3         --
-- V SYNC POL = Positive  -- V SYNC POL = Positive  -- V SYNC POL = Positive  --
--------------------------------------------------------------------------------

	type Direction is (Horiz, Vert);
	type TimingInfo is
		record
			Displayed    : natural;
			BackPorch    : natural;
			FrontPorch   : natural;
			SyncPulse    : natural;
			SyncPolarity : STD_LOGIC;
		end record;
	type Mode is array (0 to 17, Direction'left to Direction'right) of TimingInfo;

	constant Monitor : Mode := (

	-- 25MHz Clock        (59Hz)    ----------------
	(( 640,  48,  16,  96, '0'),    -- MONITOR  0 --
	 ( 480,  29,  10,   2, '0')),   ----------------

	-- 25.17MHz Clock     (60Hz)    ----------------
	(( 640,  48,  16,  96, '0'),    -- MONITOR  1 --
	 ( 480,  31,  11,   2, '0')),   ----------------

	-- 31.5MHz Clock      (72Hz)    ----------------
	(( 640, 128,  24,  40, '0'),    -- MONITOR  2 --
	 ( 480,  28,   9,   3, '0')),   ----------------

	-- 31.5MHz Clock      (75Hz)    ----------------
	(( 640,  48,  16,  96, '0'),    -- MONITOR  3 --
	 ( 480,  32,  11,   2, '0')),   ----------------

	-- 36MHz Clock        (85Hz)    ----------------
	(( 640, 112,  32,  48, '0'),    -- MONITOR  4 --
	 ( 480,  25,   1,   3, '0')),   ----------------

	-- 36MHz Clock        (56Hz)    ----------------
	(( 800, 128,  24,  72, '1'),    -- MONITOR  5 --
	 ( 600,  25,   1,   3, '1')),   ----------------

	-- 38.1MHz Clock      (56Hz)    ----------------
	(( 800, 128,  32, 128, '0'),    -- MONITOR  6 --
	 ( 600,  14,   1,   4, '0')),   ----------------

	-- 40MHz Clock        (60Hz)    ----------------
	(( 800,  88,  40, 128, '1'),    -- MONITOR  7 --
	 ( 600,  23,   1,   4, '1')),   ----------------

	-- 50MHz Clock        (72Hz)    ----------------
	(( 800,  64,  56, 120, '1'),    -- MONITOR  8 --
	 ( 600,  23,  37,   6, '1')),   ----------------

	-- 49.5MHz Clock      (75Hz)    ----------------
	(( 800, 160,  16,  80, '1'),    -- MONITOR  9 --
	 ( 600,  21,   1,   2, '1')),   ----------------

	-- 56.25MHz Clock     (85Hz)    ----------------
	(( 800, 152,  32,  64, '1'),    -- MONITOR 10 --
	 ( 600,  27,   1,   3, '1')),   ----------------

	-- 65MHz Clock        (60Hz)    ----------------
	((1024, 160,  24, 136, '0'),    -- MONITOR 11 --
	 ( 768,  29,   3,   6, '0')),   ----------------

	-- 72MHz Clock        (70Hz)    ----------------
	((1024,  88,  32, 136, '0'),    -- MONITOR 12 --
	 ( 768,  30,   2,   6, '0')),   ----------------

	-- 75MHz Clock        (70Hz)    ----------------
	((1024, 144,  24, 136, '0'),    -- MONITOR 13 --
	 ( 768,  29,   3,   6, '0')),   ----------------

	-- 78.75MHz Clock     (75Hz)    ----------------
	((1024, 176,  16,  96, '1'),    -- MONITOR 14 --
	 ( 768,  28,   1,   3, '1')),   ----------------

	-- 94.5MHz Clock      (85Hz)    ----------------
	((1024, 208,  48,  96, '1'),    -- MONITOR 15 --
	 ( 768,  36,   1,   3, '1')),   ----------------

	-- 108MHz Clock       (75Hz)    ----------------
	((1152, 256,  64, 128, '1'),    -- MONITOR 16 --
	 ( 864,  32,   1,   3, '1')),   ----------------

	-- 108MHz Clock       (60Hz)    ----------------
	((1280, 248,  48, 112, '1'),    -- MONITOR 17 --
	 (1024,  38,   1,   3, '1'))    ----------------
	);

	-- Enter your selected monitor mode HERE
	--                                   ||
	--                                   ||
	--                                   \/
	constant SELECTED : natural :=       6; -- everything else adjusts accordingly ;)
	
	constant HBP : natural := Monitor(SELECTED, Horiz).BackPorch;        -- Horizontal Back Porch end
	constant HAV : natural := HBP + Monitor(SELECTED, Horiz).Displayed;  -- Horizontal Active Video end
	constant HFP : natural := HAV + Monitor(SELECTED, Horiz).FrontPorch; -- Horizontal Front Porch end
	constant HP  : natural := HFP + Monitor(SELECTED, Horiz).SyncPulse;  -- Horizontal Sync Pulse end
	constant HSP : STD_LOGIC := Monitor(SELECTED, Horiz).SyncPolarity;   -- Horizontal Sync Polariry

	constant VBP : natural := Monitor(SELECTED, Vert).BackPorch;         -- Vertical Back Porch end
	constant VAV : natural := VBP + Monitor(SELECTED, Vert).Displayed;   -- Vertical Active Video end
	constant VFP : natural := VAV + Monitor(SELECTED, Vert).FrontPorch;  -- Vertical Front Porch end
	constant VP  : natural := VFP + Monitor(SELECTED, Vert).SyncPulse;   -- Vertical Sync Pulse end
	constant VSP : STD_LOGIC := Monitor(SELECTED, Vert).SyncPolarity;    -- Vertical Sync Polariry

	constant CHARWIDTH   : natural := 8;
	constant CHARHEIGHT  : natural := 12;

	constant TOTALPIXELS : natural := Monitor(SELECTED, Horiz).Displayed * Monitor(SELECTED, Vert).Displayed;
	constant TEXTROWS    : natural := Monitor(SELECTED, Vert).Displayed / CHARHEIGHT;
	constant TEXTCOLUMNS : natural := Monitor(SELECTED, Horiz).Displayed / CHARWIDTH;
	constant TOTALCHARS  : natural := TEXTROWS * TEXTCOLUMNS;
	constant ADDRESSLENGTH : natural := BitsNecessary(TOTALCHARS - 1);

	type RGB is
		record
			R : STD_LOGIC;
			G : STD_LOGIC;
			B : STD_LOGIC;
		end record;

	type BasicColours is (Black, Blue, Green, Cyan, Red, Magenta, Yellow, White);
	type ColourRGB is array (BasicColours'left to BasicColours'right) of RGB;
	constant COLOUR : ColourRGB := (
	
	('0', '0', '0'),  -- Black
	('0', '0', '1'),  -- Blue
	('0', '1', '0'),  -- Green
	('0', '1', '1'),  -- Cyan
	('1', '0', '0'),  -- Red
	('1', '0', '1'),  -- Magenta
	('1', '1', '0'),  -- Yellow
	('1', '1', '1')); -- White

	type ROM is array (0 to 126, 0 to 11) of std_logic_vector(0 to 7);
	constant PixelMap : ROM := (

		15 => ("10101010",	--  Block
			   "01010101",
			   "10101010",
			   "01010101",
			   "10101010",
			   "01010101",
			   "10101010",
			   "01010101",
			   "10101010",
			   "01010101",
			   "10101010",
			   "01010101"),

		16 => ("11111111",	--  Block
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111",
			   "11111111"),

		32 => ("00000000",	--  Space
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		33 => ("00000000",	--  !
			   "00110000",
			   "01111000",
			   "01111000",
			   "01111000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00000000"),

		34 => ("00000000",	--  "
			   "01100110",
			   "01100110",
			   "01100110",
			   "00100100",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		35 => ("00000000",	--  #
			   "01101100",
			   "01101100",
			   "11101110",
			   "01101100",
			   "01101100",
			   "01101100",
			   "11101110",
			   "01101100",
			   "01101100",
			   "00000000",
			   "00000000"),

		36 => ("00110000",	--  $
			   "00110000",
			   "01111100",
			   "11000000",
			   "11000000",
			   "01111000",
			   "00001100",
			   "00001100",
			   "11111000",
			   "00110000",
			   "00110000",
			   "00000000"),

		37 => ("00000000",	--  %
			   "00000000",
			   "00000000",
			   "11000100",
			   "11001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "11001100",
			   "10001100",
			   "00000000",
			   "00000000"),

		38 => ("00000000",	--  &
			   "01110000",
			   "11011000",
			   "11011000",
			   "01110000",
			   "11111010",
			   "11011110",
			   "11001100",
			   "11011100",
			   "01110110",
			   "00000000",
			   "00000000"),

		39 => ("00000000",	--  '
			   "00110000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		40 => ("00000000",	--  (
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "01100000",
			   "01100000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00000000",
			   "00000000"),

		41 => ("00000000",	--  )
			   "01100000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "00000000",
			   "00000000"),

		42 => ("00000000",	--  *
			   "00000000",
			   "00000000",
			   "11000011",
			   "00111100",
			   "11111111",
			   "00111100",
			   "11000011",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		43 => ("00000000",	--  +
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "01111110",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		44 => ("00000000",	--  ,
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00110000",
			   "00000000"),

		45 => ("00000000",	--  -
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "11111110",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		46 => ("00000000",	--  .
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000"),

		47 => ("00000000",	--  /
			   "00000000",
			   "00000010",
			   "00000110",
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "11000000",
			   "10000000",
			   "00000000",
			   "00000000"),

		48 => ("00000000",	-- 0
			   "01111100",
			   "11000110",
			   "11001110",
			   "11011110",
			   "11010110",
			   "11110110",
			   "11100110",
			   "11000110",
			   "01111100",
			   "00000000",
			   "00000000"),

		49 => ("00000000",	--  1
			   "00010000",
			   "00110000",
			   "11110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "11111100",
			   "00000000",
			   "00000000"),

		50 => ("00000000",	--  2
			   "01111000",
			   "11001100",
			   "11001100",
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "11001100",
			   "11111100",
			   "00000000",
			   "00000000"),

		51 => ("00000000",	--  3
			   "01111000",
			   "11001100",
			   "00001100",
			   "00001100",
			   "00111000",
			   "00001100",
			   "00001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		52 => ("00000000",	--  4
			   "00001100",
			   "00011100",
			   "00111100",
			   "01101100",
			   "11001100",
			   "11111110",
			   "00001100",
			   "00001100",
			   "00011110",
			   "00000000",
			   "00000000"),

		53 => ("00000000",	--  5
			   "11111100",
			   "11000000",
			   "11000000",
			   "11000000",
			   "11111000",
			   "00001100",
			   "00001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		54 => ("00000000",	--  6
			   "00111000",
			   "01100000",
			   "11000000",
			   "11000000",
			   "11111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		55 => ("00000000",	--  7
			   "11111110",
			   "11000110",
			   "11000110",
			   "00000110",
			   "00001100",
			   "00011000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00000000"),

		56 => ("00000000",	--  8
			   "01111000",
			   "11001100",
			   "11001100",
			   "11101100",
			   "01111000",
			   "11011100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		57 => ("00000000",	--  9
			   "01111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111100",
			   "00011000",
			   "00011000",
			   "00110000",
			   "01110000",
			   "00000000",
			   "00000000"),

		58 => ("00000000",	--  :
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000",
			   "00000000"),

		59 => ("00000000",	--  ;
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00110000",
			   "00000000",
			   "00000000"),

		60 => ("00000000",	--  <
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "11000000",
			   "01100000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00000000",
			   "00000000"),

		61 => ("00000000",	--  =
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111110",
			   "00000000",
			   "01111110",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		62 => ("00000000",	--  >
			   "01100000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00000110",
			   "00001100",
			   "00011000",
			   "00110000",
			   "01100000",
			   "00000000",
			   "00000000"),

		63 => ("00000000",	--  ?
			   "01111000",
			   "11001100",
			   "00001100",
			   "00011000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00110000",
			   "00110000",
			   "00000000",
			   "00000000"),

		64 => ("00000000",	--  @
			   "01111100",
			   "11000110",
			   "11000110",
			   "11011110",
			   "11011110",
			   "11011110",
			   "11000000",
			   "11000000",
			   "01111100",
			   "00000000",
			   "00000000"),

		65 => ("00000000",	--  A
			   "00110000",
			   "01111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11111100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "00000000",
			   "00000000"),

		66 => ("00000000",	--  B
			   "11111100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01111100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "11111100",
			   "00000000",
			   "00000000"),

		67 => ("00000000",	--  C
			   "00111100",
			   "01100110",
			   "11000110",
			   "11000000",
			   "11000000",
			   "11000000",
			   "11000110",
			   "01100110",
			   "00111100",
			   "00000000",
			   "00000000"),

		68 => ("00000000",	--  D
			   "11111000",
			   "01101100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01101100",
			   "11111000",
			   "00000000",
			   "00000000"),

		69 => ("00000000",	--  E
			   "11111110",
			   "01100010",
			   "01100000",
			   "01100100",
			   "01111100",
			   "01100100",
			   "01100000",
			   "01100010",
			   "11111110",
			   "00000000",
			   "00000000"),

		70 => ("00000000",	--  F
			   "11111110",
			   "01100110",
			   "01100000",
			   "01100100",
			   "01111100",
			   "01100100",
			   "01100000",
			   "01100000",
			   "11110000",
			   "00000000",
			   "00000000"),

		71 => ("00000000",	--  G
			   "00111100",
			   "01100110",
			   "11000110",
			   "11000000",
			   "11000000",
			   "11001110",
			   "11000110",
			   "01100110",
			   "00111110",
			   "00000000",
			   "00000000"),

		72 => ("00000000",	--  H
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11111100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "00000000",
			   "00000000"),

		73 => ("00000000",	--  I
			   "01111000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "01111000",
			   "00000000",
			   "00000000"),

		74 => ("00000000",	--  J
			   "00011110",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		75 => ("00000000",	--  K
			   "11100110",
			   "01100110",
			   "01101100",
			   "01101100",
			   "01111000",
			   "01101100",
			   "01101100",
			   "01100110",
			   "11100110",
			   "00000000",
			   "00000000"),

		76 => ("00000000",	--  L
			   "11100000",
			   "01100000",
			   "01100000",
			   "01100000",
			   "01100000",
			   "01100010",
			   "01100110",
			   "01100110",
			   "11111110",
			   "00000000",
			   "00000000"),

		77 => ("00000000",	--  M
			   "11000110",
			   "11101110",
			   "11111110",
			   "11111110",
			   "11010110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "00000000",
			   "00000000"),

		78 => ("00000000",	--  N
			   "11000110",
			   "11000110",
			   "11100110",
			   "11110110",
			   "11111110",
			   "11011110",
			   "11001110",
			   "11000110",
			   "11000110",
			   "00000000",
			   "00000000"),

		79 => ("00000000",	--  O
			   "00111000",
			   "01101100",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "01101100",
			   "00111000",
			   "00000000",
			   "00000000"),

		80 => ("00000000",	--  P
			   "11111100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01111100",
			   "01100000",
			   "01100000",
			   "01100000",
			   "11110000",
			   "00000000",
			   "00000000"),

		81 => ("00000000",	--  Q
			   "00111000",
			   "01101100",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11001110",
			   "11011110",
			   "01111100",
			   "00001100",
			   "00011110",
			   "00000000"),

		82 => ("00000000",	--  R
			   "11111100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01111100",
			   "01101100",
			   "01100110",
			   "01100110",
			   "11100110",
			   "00000000",
			   "00000000"),

		83 => ("00000000",	--  S
			   "01111000",
			   "11001100",
			   "11001100",
			   "11000000",
			   "01110000",
			   "00011000",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		84 => ("00000000",	--  T
			   "11111100",
			   "10110100",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "01111000",
			   "00000000",
			   "00000000"),

		85 => ("00000000",	--  U
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		86 => ("00000000",	--  V
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00110000",
			   "00000000",
			   "00000000"),

		87 => ("00000000",	--  W
			   "11000110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11010110",
			   "11010110",
			   "01101100",
			   "01101100",
			   "01101100",
			   "00000000",
			   "00000000"),

		88 => ("00000000",	--  X
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00110000",
			   "01111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "00000000",
			   "00000000"),

		89 => ("00000000",	--  Y
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "01111000",
			   "00000000",
			   "00000000"),

		90 => ("00000000",	--  Z
			   "11111110",
			   "11001110",
			   "10011000",
			   "00011000",
			   "00110000",
			   "01100000",
			   "01100010",
			   "11000110",
			   "11111110",
			   "00000000",
			   "00000000"),

		91 => ("00000000",	--  [
			   "00111100",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00111100",
			   "00000000",
			   "00000000"),

		92 => ("00000000",	--  \
			   "00000000",
			   "10000000",
			   "11000000",
			   "01100000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00000110",
			   "00000010",
			   "00000000",
			   "00000000"),

		93 => ("00000000",	--  ]
			   "00111100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00111100",
			   "00000000",
			   "00000000"),

		94 => ("00010000",	--  ^
			   "00111000",
			   "01101100",
			   "11000110",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		95 => ("00000000",	--  _
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "11111111",
			   "00000000"),

		97 => ("00000000",	--  a
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111000",
			   "00001100",
			   "01111100",
			   "11001100",
			   "11001100",
			   "01110110",
			   "00000000",
			   "00000000"),

		98 => ("00000000",	--  b
			   "11100000",
			   "01100000",
			   "01100000",
			   "01111100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "11011100",
			   "00000000",
			   "00000000"),

		99 => ("00000000",	--  c
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111000",
			   "11001100",
			   "11000000",
			   "11000000",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		100 =>("00000000",	--  d
			   "00001110",
			   "00000110",
			   "00000110",
			   "01111110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "11000110",
			   "01111011",
			   "00000000",
			   "00000000"),

		101 =>("00000000",	--  e
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111000",
			   "11001100",
			   "11111100",
			   "11000000",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		102 =>("00000000",	--  f
			   "00111000",
			   "01101100",
			   "01100000",
			   "01100000",
			   "11111000",
			   "01100000",
			   "01100000",
			   "01100000",
			   "11110000",
			   "00000000",
			   "00000000"),

		103 =>("00000000",	--  g
			   "00000000",
			   "00000000",
			   "00000000",
			   "01110110",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111100",
			   "00001100",
			   "11001100",
			   "01111000"),

		104 =>("00000000",	--  h
			   "11100000",
			   "01100000",
			   "01100000",
			   "01101100",
			   "01110110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "11100110",
			   "00000000",
			   "00000000"),

		105 =>("00000000",	--  i
			   "00110000",
			   "00110000",
			   "00000000",
			   "11110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "11111100",
			   "00000000",
			   "00000000"),

		106 =>("00000000",	--  j
			   "00001100",
			   "00001100",
			   "00000000",
			   "00111100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "00001100",
			   "11001100",
			   "11001100",
			   "01111000"),

		107 =>("00000000",	--  k
			   "11100000",
			   "01100000",
			   "01100000",
			   "01100110",
			   "01101100",
			   "01111000",
			   "01101100",
			   "01100110",
			   "11100110",
			   "00000000",
			   "00000000"),

		108 =>("00000000",	--  l
			   "11110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "00110000",
			   "11111100",
			   "00000000",
			   "00000000"),

		109 =>("00000000",	--  m
			   "00000000",
			   "00000000",
			   "00000000",
			   "11111100",
			   "11010110",
			   "11010110",
			   "11010110",
			   "11010110",
			   "11000110",
			   "00000000",
			   "00000000"),

		110 =>("00000000",	--  n
			   "00000000",
			   "00000000",
			   "00000000",
			   "11111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "00000000",
			   "00000000"),

		111 =>("00000000",	--  o
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		112 =>("00000000",	--  p
			   "00000000",
			   "00000000",
			   "00000000",
			   "11011100",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01111100",
			   "01100000",
			   "11110000"),

		113 =>("00000000",	--  q
			   "00000000",
			   "00000000",
			   "00000000",
			   "01110110",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111100",
			   "00001100",
			   "00011110"),

		114 =>("00000000",	--  r
			   "00000000",
			   "00000000",
			   "00000000",
			   "11101100",
			   "01101110",
			   "01110110",
			   "01100000",
			   "01100000",
			   "11110000",
			   "00000000",
			   "00000000"),

		115 =>("00000000",	--  s
			   "00000000",
			   "00000000",
			   "00000000",
			   "01111000",
			   "11001100",
			   "01100000",
			   "00011000",
			   "11001100",
			   "01111000",
			   "00000000",
			   "00000000"),

		116 =>("00000000",	--  t
			   "00000000",
			   "00100000",
			   "01100000",
			   "11111100",
			   "01100000",
			   "01100000",
			   "01100000",
			   "01101100",
			   "00111000",
			   "00000000",
			   "00000000"),

		117 =>("00000000",	--  u
			   "00000000",
			   "00000000",
			   "00000000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01110110",
			   "00000000",
			   "00000000"),

		118 =>("00000000",	--  v
			   "00000000",
			   "00000000",
			   "00000000",
			   "11001100",
			   "11001100",
			   "11001100",
			   "11001100",
			   "01111000",
			   "00110000",
			   "00000000",
			   "00000000"),

		119 =>("00000000",	--  w
			   "00000000",
			   "00000000",
			   "00000000",
			   "11000110",
			   "11000110",
			   "11010110",
			   "11010110",
			   "01101100",
			   "01101100",
			   "00000000",
			   "00000000"),

		120 =>("00000000",	--  x
			   "00000000",
			   "00000000",
			   "00000000",
			   "11000110",
			   "01101100",
			   "00111000",
			   "00111000",
			   "01101100",
			   "11000110",
			   "00000000",
			   "00000000"),

		121 =>("00000000",	--  y
			   "00000000",
			   "00000000",
			   "00000000",
			   "01100110",
			   "01100110",
			   "01100110",
			   "01100110",
			   "00111100",
			   "00001100",
			   "00011000",
			   "11110000"),

		122 =>("00000000",	--  z
			   "00000000",
			   "00000000",
			   "00000000",
			   "11111100",
			   "10001100",
			   "00011000",
			   "01100000",
			   "11000100",
			   "11111100",
			   "00000000",
			   "00000000"),

		123 =>("00000000",	--  {
			   "00011100",
			   "00110000",
			   "00110000",
			   "01100000",
			   "11000000",
			   "01100000",
			   "00110000",
			   "00110000",
			   "00011100",
			   "00000000",
			   "00000000"),

		124=> ("00000000",	--  |
			   "00011000",
			   "00011000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00011000",
			   "00011000",
			   "00011000",
			   "00011000",
			   "00000000",
			   "00000000"),

		125=> ("00000000",	--  }
			   "11100000",
			   "00110000",
			   "00110000",
			   "00011000",
			   "00001100",
			   "00011000",
			   "00110000",
			   "00110000",
			   "11100000",
			   "00000000",
			   "00000000"),

		126=> ("00000000",	--  ~
			   "01110011",
			   "11011010",
			   "11001110",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000",
			   "00000000"),

		others => (others => x"00") );

end Monitor;

package body Monitor is

	function BitsNecessary(Number : natural)
		return natural is

		variable Bits : natural;

	begin
		case Number is
			when 0 to 1 => Bits := 1;
			when 2 to 3 => Bits := 2;
			when 4 to 7 => Bits := 3;
			when 8 to 15 => Bits := 4;
			when 16 to 31 => Bits := 5;
			when 32 to 63 => Bits := 6;
			when 64 to 127 => Bits := 7;
			when 128 to 255 => Bits := 8;
			when 256 to 511 => Bits := 9;
			when 512 to 1023 => Bits := 10;
			when 1024 to 2047 => Bits := 11;
			when 2048 to 4095 => Bits := 12;
			when 4096 to 8191 => Bits := 13;
			when 8192 to 16383 => Bits := 14;
			when 16384 to 32767 => Bits := 15;
			when 32768 to 65535 => Bits := 16;
			when 65536 to 131071 => Bits := 17;
			when 131072 to 262143 => Bits := 18;
			when 262144 to 524287 => Bits := 19;
			when 524288 to 1048575 => Bits := 20;
			when 1048576 to 2097151 => Bits := 21;
			when others => Bits := 0;
		end case;
		return Bits;
	end BitsNecessary;

end Monitor;
