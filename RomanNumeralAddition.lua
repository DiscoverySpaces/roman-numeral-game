require "string"



function UpConvert(s)
  UpConversions={{'IIIII','V'},{'VIV','IX'},{'VV','X'},{'XXXXX','L'},{'LXL','XC'},{'LL','C'},{'CCCCC','D'},{'DCD','CM'},{'DD','M'}}
  TempString=s
  for i,v in ipairs(UpConversions) do
    TempString,ICount=string.gsub(TempString,v[1],v[2])
  end
  UpConverted=TempString
  return UpConverted
end

function SwitchSubtractives(numeral,switch)
  AllSubtractives = {{'IV','IIII'},{'IX','VIIII'},{'XL','XXXX'},{'XC','LXXXX'},{'CD','CCCC'},{'CM','DCCCC'}}
  for i, v in ipairs(AllSubtractives) do
    if (switch =='extract') then
      numeral, IVCount = string.gsub(numeral,v[1], v[2])
    elseif switch=='restore' then
      numeral, IVCount = string.gsub(numeral,v[2], v[1])
      numeral=UpConvert(numeral)
    else
      error('Error!, incorrect switch value used, expecting extract or restore',switch)
    end
  end
  return numeral
end



function SortLargerToSmallerSymbols(s) --time this carefully to see if it might be faster to use a sorting algorithm rather than recreating the number with string.repetition
  --extricate and count all symbols then rebuild in order set by symbol table
  t = { 'M','D','C','L','X','V','I' }
  SortedNumeral=''
  for i,v in ipairs(t) do
    s, Count = string.gsub(s, v, "");
    SortedNumeral=SortedNumeral..string.rep(v,Count)
  end
  return SortedNumeral
end


--put it all together, starting from 2 numbers
function AddTwoRomanNumerals(input1,input2)
  --extract subtractives
  OnlyAdditivesForInput1=SwitchSubtractives(input1,'extract')
  OnlyAdditivesForInput2=SwitchSubtractives(input2,'extract')

  --merge the two inputs so we can sort them out
  OnlyAdditives=OnlyAdditivesForInput1..OnlyAdditivesForInput2

  --sort larger to smaller
  SortedNumeral=SortLargerToSmallerSymbols(OnlyAdditives)
  --upconvert
  UpConverted=UpConvert(SortedNumeral)
  --restore subtractives
  RestoredSub=SwitchSubtractives(UpConverted,'restore')

  return RestoredSub
end

function InputMultipleRomanNumerals()  --warning: no tests on this one yet!
  sum=''
  while current ~='' do
      print("Enter another numeral. Just press enter when done.")
      current = io.read("*line")
      print(current)
      OnlyAdditives=SwitchSubtractives(current,'extract')
      sum=sum..OnlyAdditives
  end
  --sort larger to smaller
  SortedNumeral=SortLargerToSmallerSymbols(sum)
  --upconvert
  UpConverted=UpConvert(SortedNumeral)
  --restore subtractives
  result=SwitchSubtractives(UpConverted,'restore')
  
  return result
end
