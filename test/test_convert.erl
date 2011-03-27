%% Author: carl
%% Created: 20 Mar 2011
%% Description: TODO: Add description to test_convert
-module(test_convert).

%%
%% Include files
%%
-include_lib("eunit/include/eunit.hrl").

%%
%% Exported Functions
%%
-export([]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
digit_to_ascii_hex_test() ->
	"0" = erl8583_convert:digit_to_ascii_hex(0),
	"9" = erl8583_convert:digit_to_ascii_hex(9),
	"A" = erl8583_convert:digit_to_ascii_hex(10),
	"F" = erl8583_convert:digit_to_ascii_hex(15),
	?assertError(_, erl8583_convert:digit_to_ascii_hex(16)).

ascii_hex_to_digit_test() ->
	0 = erl8583_convert:ascii_hex_to_digit("0"),
	9 = erl8583_convert:ascii_hex_to_digit("9"),
	10 = erl8583_convert:ascii_hex_to_digit("A"),
	15 = erl8583_convert:ascii_hex_to_digit("F"),
	10 = erl8583_convert:ascii_hex_to_digit("a"),
	15 = erl8583_convert:ascii_hex_to_digit("f"),
	?assertError(_, erl8583_convert:ascii_hex_to_digit("G")).

string_to_ascii_hex_test() ->
	"" = erl8583_convert:string_to_ascii_hex(""),
	"30" = erl8583_convert:string_to_ascii_hex("0"),
	"48656C6C6F" = erl8583_convert:string_to_ascii_hex("Hello").

ascii_hex_to_string_test() ->
	"" = erl8583_convert:ascii_hex_to_string(""),
	"Hello" = erl8583_convert:ascii_hex_to_string("48656C6c6F").

binary_to_ascii_hex_test() ->
	"00FFA5" = erl8583_convert:binary_to_ascii_hex(<<0, 255, 165>>).

ascii_hex_to_binary_test() ->
	<<0, 255, 165>> = erl8583_convert:ascii_hex_to_binary("00FFa5").

concat_binaries_test() ->
	<<1, 2, 3, 4>> = erl8583_convert:concat_binaries([<<1>>, <<2, 3>>, <<4>>]).

integer_to_bcd_test() ->
	<<1>> = erl8583_convert:integer_to_bcd(1, 1),
	<<1>> = erl8583_convert:integer_to_bcd(1, 2),
	<<0, 1>> = erl8583_convert:integer_to_bcd(1, 3),
	<<16>> = erl8583_convert:integer_to_bcd(10, 2),
	<<0, 16>> = erl8583_convert:integer_to_bcd(10, 3),
	<<9, 153>> = erl8583_convert:integer_to_bcd(999, 3),
	<<0,18,52,86,120>> = erl8583_convert:integer_to_bcd(12345678, 10),
	<<1,35,69,103,137>> = erl8583_convert:integer_to_bcd(123456789, 9),
	?assertError(_, erl8583_convert:integer_to_bcd(1000, 3)).

ascii_hex_to_bcd_test() ->
	<<48, 31>> = erl8583_convert:ascii_hex_to_bcd("301", "F"),
	<<64, 31>> = erl8583_convert:ascii_hex_to_bcd("401", "F"),
	<<48, 16>> = erl8583_convert:ascii_hex_to_bcd("301", "0"),
	<<18, 52>> = erl8583_convert:ascii_hex_to_bcd("1234", "0").

bcd_to_integer_test() ->
	17 = erl8583_convert:bcd_to_integer(<<23>>),
	1 = erl8583_convert:bcd_to_integer(<<1>>),
	1 = erl8583_convert:bcd_to_integer(<<0, 1>>),
	123 = erl8583_convert:bcd_to_integer(<<1, 35>>),
	123456 = erl8583_convert:bcd_to_integer(<<18, 52, 86>>).

bcd_to_ascii_hex_test() ->
	"1234" = erl8583_convert:bcd_to_ascii_hex(<<18, 52>>, 4, "F"),
	"123" = erl8583_convert:bcd_to_ascii_hex(<<18, 63>>, 3, "F"),
	"123" = erl8583_convert:bcd_to_ascii_hex(<<18, 48>>, 3, "0"),
	"401" = erl8583_convert:bcd_to_ascii_hex(<<64, 31>>, 3, "F").

track2_to_string_test() ->
	";1234123412341234=0305101193010877?" = erl8583_convert:track2_to_string(<<177, 35, 65, 35, 65, 35, 65, 35, 77, 3, 5, 16, 17, 147, 1, 8, 119, 240>>,  35).

string_to_track2_test() ->
	<<177, 35, 65, 35, 65, 35, 65, 35, 77, 3, 5, 16, 17, 147, 1, 8, 119, 240>> = erl8583_convert:string_to_track2(";1234123412341234=0305101193010877?").

strip_leading_spaces_test() ->
	"hello" = erl8583_convert:strip_trailing_spaces("hello"),
	"hello" =  erl8583_convert:strip_trailing_spaces("hello   "),
	"    hello" =  erl8583_convert:strip_trailing_spaces("    hello  ").

strip_leading_zeroes_test() ->
	"1234" = erl8583_convert:strip_leading_zeroes("1234"),
	"2345" = erl8583_convert:strip_leading_zeroes("0000000002345").

ascii_to_ebcdic_lower_case_chars_test() ->
	<<129, 130, 131, 132, 133, 134, 135, 136, 137>> = erl8583_convert:ascii_to_ebcdic("abcdefghi"),
	<<145, 146, 147, 148, 149, 150, 151, 152, 153>> = erl8583_convert:ascii_to_ebcdic("jklmnopqr"),
	<<162, 163, 164, 165, 166, 167, 168, 169>> = erl8583_convert:ascii_to_ebcdic("stuvwxyz").
	
ascii_to_ebcdic_upper_case_chars_test() ->
	<<193, 194, 195, 196, 197, 198, 199, 200, 201>> = erl8583_convert:ascii_to_ebcdic("ABCDEFGHI"),
	<<209, 210, 211, 212, 213, 214, 215, 216, 217>> = erl8583_convert:ascii_to_ebcdic("JKLMNOPQR"),
	<<226, 227, 228, 229, 230, 231, 232, 233>> = erl8583_convert:ascii_to_ebcdic("STUVWXYZ").

ascii_to_ebcdic_digits_test() ->
	<<240, 241, 242, 243, 244, 245, 246, 247, 248, 249>> = erl8583_convert:ascii_to_ebcdic("0123456789").

ascii_to_ebcdic_punctuation_1_test() ->
	<<64>> = erl8583_convert:ascii_to_ebcdic(" "),
	<<75>> = erl8583_convert:ascii_to_ebcdic("."),
	<<76>> = erl8583_convert:ascii_to_ebcdic("<"),
	<<77>> = erl8583_convert:ascii_to_ebcdic("("),
	<<78>> = erl8583_convert:ascii_to_ebcdic("+"),
	<<79>> = erl8583_convert:ascii_to_ebcdic("|"),
	<<80>> = erl8583_convert:ascii_to_ebcdic("&").

ascii_to_ebcdic_punctuation_2_test() ->
	<<90>> = erl8583_convert:ascii_to_ebcdic("!"),
	<<91>> = erl8583_convert:ascii_to_ebcdic("$"),
	<<92>> = erl8583_convert:ascii_to_ebcdic("*"),
	<<93>> = erl8583_convert:ascii_to_ebcdic(")"),
	<<94>> = erl8583_convert:ascii_to_ebcdic(";").

ascii_to_ebcdic_punctuation_3_test() ->
	<<96>> = erl8583_convert:ascii_to_ebcdic("-"),
	<<97>> = erl8583_convert:ascii_to_ebcdic("/"),
	<<96>> = erl8583_convert:ascii_to_ebcdic([45]).

ascii_to_ebcdic_punctuation_4_test() ->
	<<107>> = erl8583_convert:ascii_to_ebcdic(","),
	<<108>> = erl8583_convert:ascii_to_ebcdic("%"),
	<<109>> = erl8583_convert:ascii_to_ebcdic("_"),
	<<110>> = erl8583_convert:ascii_to_ebcdic(">"),
	<<111>> = erl8583_convert:ascii_to_ebcdic("?").
