-module(example_6_postilion_message).

-export([test/0]).

test() ->
	Marshalled = "30323030F23E049508E0810000000000" ++
   "04000022313630353730303130353132" ++
   "32393839383433313030303030303030" ++
   "30303030303030303130313231333437" ++
   "33353030303031313133343733353130" ++
   "31323037313231303131303031303043" ++
   "30303030303030304330303030303030" ++
   "30303636323736323930303030303033" ++
   "38373032303130353730303131303031" ++
   "2020202020202020202020205A494220" ++
   "48656164204F66666963652041544D20" ++
   "202020562F49204C61676F7320202020" ++
   "30314E47353636303034313531303130" ++
   "34303930313236363539303135323131" ++
   "32303132303331343430303230303031" ++
   "3135601C100000000000313030303030" ++
   "3338373032305A656E69746841544D73" ++
   "63725A4942655472616E7A536E6B3030" ++
   "303030323030303031315A656E697468" ++
   "54472020202031325A4942655472616E" ++
   "7A536E6B303132333431303030303120" ++
   "20203536365A454E4954482042323030" ++
   "3630393231",
	Message = example_6_unmarshaller:unmarshal(Marshalled),
	FieldIds = erl8583_message:get_fields(Message),
	F = fun(FieldId) -> 
				FieldValue = erl8583_message:get(FieldId, Message),
				io:format("Field ~p: ~p~n", [FieldId, FieldValue]) 
		end,
	lists:map(F, FieldIds),
	ok.