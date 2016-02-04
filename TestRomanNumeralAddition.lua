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
end

function test_add_romans()

--COUNT FROM 1 TO 12 switching input order
BasicNumeralTestData = {{'I','I','II'},{'I','II','III'},{'I','III','IV'},{'IV','I','V'},{'V','I','VI'},{'VI','I','VII'},{'I','VII','VIII'},{'I','VIII','IX'},{'I','IX','X'},{'I','X','XI'},{'XI','I','XII'}}

for i, v in ipairs(BasicNumeralTestData) do
-- law of commutation applies to Roman Numerals:
	lunatest.assert_equal(AddTwoRomanNumerals(v[1],v[2]),v[3])
	lunatest.assert_equal(AddTwoRomanNumerals(v[2],v[1]),v[3])

end
	--OTHER ADDS
	lunatest.assert_equal(AddTwoRomanNumerals('MCMXLVIII','DCCXLIV'),'MMDCXCII')-- which is 1948+744=2692')
	lunatest.assert_equal(AddTwoRomanNumerals('MMM','CMXCIX'),'MMMCMXCIX')-- 3000+999=3999')
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
lunatest.run()
