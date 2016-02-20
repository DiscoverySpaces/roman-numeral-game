require "RomanNumeralAddition"
local lunatest = require "lunatest"
--lunatest.suite("basic-roman-numerals")

function test_sort()
	lunatest.assert_equal(SortLargerToSmallerSymbols("LXXIXXDCCCXCCCMCCXXDXVIIIIIIID"),'MDDDCCCCCCCCLXXXXXXXXVIIIIIIII')
end

function test_UpConvert()
lunatest.assert_equal(UpConvert('IIIII'),'V',"this should be converted to 'V' because that is the equivalent of 5 I's")
lunatest.assert_equal(UpConvert('DCCCCCCCCLXXXXXXXXVIIIIIIII'),'MCCCCXXXXIII',"this test includes all roman numerals")
--THESE ARE SUBTRACTIVE TO SUBTRACTIVE UPCONVERSIONS
lunatest.assert_equal(UpConvert('DCD'),'CM',"an odd Case, program wants to return DCD")
lunatest.assert_equal(UpConvert('VIV'),'IX',"an odd Case, program wants to return VIV")
lunatest.assert_equal(UpConvert('LXL'),'XC',"an odd Case, program wants to return LXL")
lunatest.assert_equal(UpConvert('MMMM'),'(IV)',"anything over 3k uses (parens) or added bar to denote time 1000")
lunatest.assert_equal('(V)', UpConvert('MMMMM')," 'MMMMM' to '(V)' anything over 3k uses (parens) or added bar to denote time 1000")
lunatest.assert_equal(UpConvert('MMMMMM'),'(VI)',"anything over 3k uses (parens) or added bar to denote time 1000")


end

function test_add_romans()

--COUNT FROM 1 TO 12 switching input order
BasicNumeralTestData = {{'I','I','II'},{'I','II','III'},{'I','III','IV'},{'IV','I','V'},{'V','I','VI'},{'VI','I','VII'},{'I','VII','VIII'},{'I','VIII','IX'},{'I','IX','X'},{'I','X','XI'},{'XI','I','XII'}}

--instead of BasicNumeralTestData array, read in from a file entered by spreadsheet


for i, v in ipairs(BasicNumeralTestData) do
-- law of commutation applies to Roman Numerals:
	lunatest.assert_equal(AddTwoRomanNumerals(v[1],v[2]),v[3])
	lunatest.assert_equal(AddTwoRomanNumerals(v[2],v[1]),v[3])

end
	--OTHER ADDS
	lunatest.assert_equal(AddTwoRomanNumerals('MCMXLVIII','DCCXLIV'),'MMDCXCII')-- which is 1948+744=2692')
	lunatest.assert_equal(AddTwoRomanNumerals('MMM','CMXCIX'),'MMMCMXCIX')-- 3000+999=3999')  --3999 
  lunatest.assert_equal(AddTwoRomanNumerals('MMM','M'),'(IV)') --Search for a count of more than 3 M's in the final number, then...MMMM to IV with an overline or easier to represent: embraced in parens (IV). It should be placed all the way to the left since it is the highest number except for subtractive form    C(IV)CMXIX   ? verify this!! 4000 would be M(V)   --see http://able2know.org/topic/54469-1
  lunatest.assert_equal(AddTwoRomanNumerals('MMMCX','MMVIII'),'(V)CXVIII') 
  lunatest.assert_equal(AddTwoRomanNumerals('MMMXIV','MMM'),'(VI)XIV') 
--[[
I	II	III	IV	V	VI	VII	VIII	IX
X	XX	XXX	XL	L	LX	LXX	LXXX	XC
C	CC	CCC	CD	D	DC	DCC	DCCC	CM
M	MM	MMM	MV	V	VM	VMM	VMMM	MX   --this is the logical consistency, 
--but what really happens is it reverts back to 1-10 counting all multiplied times 1000. IV is treated as a single numeral then x1000
--------------------------------------------
M	MM	MMM	IV	V	VI	VII	VIII	IX  --this is the way the romans did it, we think


URL: http://able2know.org/topic/54469-1
]]--  
end

function test_subtractives()
--test basics of individual pairs subtractives using Ipairs to avoid repetition:
AllSubtractives = {{'IV','IIII'},{'IX','VIIII'},{'XL','XXXX'},{'XC','LXXXX'},{'CD','CCCC'},{'CM','DCCCC'}}
for i, v in ipairs(AllSubtractives) do

  lunatest.assert_equal(SwitchSubtractives(v[1],'extract'),v[2])
  lunatest.assert_equal(SwitchSubtractives(v[2],'restore'),v[1])

end
--test all in combo subtractive pairs
lunatest.assert_equal(SwitchSubtractives('XCCMCDXLIXIV','extract'),'LXXXXDCCCCCCCCXXXXVIIIIIIII','an extraction')
lunatest.assert_equal(SwitchSubtractives(  'MCCCCXXXXIII','restore'),'MCDXLIII','1443')
end


function test_importcsv()
  allRomans=importsinglefieldcsv("roman-numeral-addition-truth-table.csv")
  print(allRomans[39])
  for i, v in ipairs(allRomans) do
-- law of commutation applies to Roman Numerals:
	lunatest.assert_equal(AddTwoRomanNumerals('I',allRomans[i]),allRomans[i+1],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('II',allRomans[i]),allRomans[i+2],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('III',allRomans[i]),allRomans[i+3],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('IV',allRomans[i]),allRomans[i+4],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('V',allRomans[i]),allRomans[i+5],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('VI',allRomans[i]),allRomans[i+6],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('VII',allRomans[i]),allRomans[i+7],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('VIII',allRomans[i]),allRomans[i+8],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('IX',allRomans[i]),allRomans[i+9],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('X',allRomans[i]),allRomans[i+10],"Testing number "..i)
	lunatest.assert_equal(AddTwoRomanNumerals('XI',allRomans[i]),allRomans[i+11],"Testing number "..i)

  end

end

lunatest.run()
