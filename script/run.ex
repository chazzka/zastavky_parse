Parse.parse("script/Zastavky_old.csv")
|> Parse.process_lines
|> IO.inspect
