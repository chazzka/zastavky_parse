# mix deps.get
# mix run script/run.ex

Parse.parse("script/Zastavky_old.csv")
|> Parse.process_lines
|> IO.inspect
