# Description
#   Allows you to connect and consume a Google Spreadsheet
#	We plan to utilise a service Sheetsu [https://sheetsu.com/] that turns a Google Spreadsheet into an API
#
# Configuration:
#   SHEETSU_LINK (environment variable) OR you can just set it below for SHEET_URL
#
# Commands:
#   hubot sheetsu all - Prints out the entire spreadsheet
#   hubot sheetsu cell <COLUMN> <ROW> - Prints out detail of a cell. eg. hubot sponsors detail A 2
#   hubot sheetsu row <ROW> - Prints out a row. eg. hubot sheetsu row 2
#
# Notes:
#	Missing 'AA' column support
#
# Author:
#   Himank Yadav <him229@gmail.com>

SHEET_URL = process.env.SHEETSU_LINK

module.exports = (robot)->

# responds to the command to print the entire spreadsheet

  robot.respond /sheetsu all/i, (message)->
    lookup_sheet message, (text)->
      message.send text

  lookup_sheet = (message, response_handler)->
    message.http( SHEET_URL ).get() (error, response, body)->

    # checks for error cases

      return response_handler "Sorry, something went wrong"                      if error
      return response_handler "404 - Not found. wtf?"    if response.statusCode == 400
      return response_handler "500 - It doesn't want anyone to go there any more." if response.statusCode == 500

      tempStr = "```" # Forms a code block in Slack
      list = JSON.parse( body ).result # Parses the JSON -> result
      for item in list
        for key,value of item
          tempStr += "#{key} : #{value}" + "\t" # Adds the key value pair from the dictionary in the list
        tempStr += "\n"
      tempStr+="```"

      response_handler tempStr



# responds to the command to print the cell content


  robot.respond /sheetsu cell ([A-Z]) (\d+)/, (message)->
    lookup_cell message, (text)->
      message.send text

  lookup_cell = (message, response_handler)->
    message.http( SHEET_URL ).get() (error, response, body)->

    # Error checking
      return response_handler "Sorry, something went wrong"                      if error
      return response_handler "404 - Not found. wtf?"    if response.statusCode == 400
      return response_handler "500 - It doesn't want anyone to go there any more." if response.statusCode == 500
      return response_handler "Row has to be 2 or greater" if message.match[1] < 2

      col_num = message.match[1].charCodeAt(0) - 'A'.charCodeAt(0) + 1
      row_num = parseInt(message.match[2], 10)
      row_num_mod = row_num - 2 # Adjusts row number to reflect the first row as reserved for title
      col_num_mod = col_num - 1 

      tempStr = "```"
      list = JSON.parse( body ).result
      array_keys = []
      for key,value of list[0]
        array_keys.push "#{key}"
      tempStr += list[row_num_mod][array_keys[col_num_mod]]

      tempStr+="```"
      response_handler tempStr



# responds to the command to print the row content

  robot.respond /sheetsu row (\d+)/i, (message)->
    lookup_row message, (text)->
      message.send text

  lookup_row = (message, response_handler)->
    message.http( SHEET_URL ).get() (error, response, body)->

    # Error Checking

      return response_handler "Sorry, something went wrong"                      if error
      return response_handler "404 - Not found. wtf?"    if response.statusCode == 400
      return response_handler "500 - It doesn't want anyone to go there any more." if response.statusCode == 500
      return response_handler "Row has to be 2 or greater" if message.match[1] < 2

      row_num = parseInt(message.match[1], 10)
      row_num_mod = row_num - 2 # Adjusts row number to reflect the first row as reserved for title

      tempStr = "```" # Code Block for Slack
      list = JSON.parse( body ).result
      for key,value of list[row_num_mod]
        tempStr += "#{key} : #{value}" + "\t" # Adds the key value pair from the dictionary in the list
      tempStr+="```"
      response_handler tempStr