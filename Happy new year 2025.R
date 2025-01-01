# Load necessary libraries
library(httr)
library(base64enc)

# Google Cloud Text-to-Speech API Key
api_key <- "AIzaSyDCsd7nDsaOyKtS0L6_1ekk2whiHOVgsEI"

# Define the general LinkedIn message text using paste() to join multiple lines
message_text <- paste(
  "Wishing everyone a Happy New Year 2025!",
  "As we reflect on the past year, we celebrate the incredible achievements, growth, and resilience.",
  "Let’s continue to transform the way we work, collaborate, and innovate in the year ahead.",
  "Here's to a year full of new opportunities, learning, and success. May 2025 bring prosperity and positivity to all!",
  "Cheers to a peaceful and brighter future and stronger connections.",
  sep = " "  # Ensures that the message is combined with spaces between lines
)

# Construct the API URL
url <- paste0("https://texttospeech.googleapis.com/v1/text:synthesize?key=", api_key)

# Send the request
response <- POST(url, 
                 body = list(input = list(text = message_text),
                             voice = list(languageCode = "en-US", name = "en-US-Wavenet-D"),
                             audioConfig = list(audioEncoding = "MP3")),
                 encode = "json")

# Check the response for errors
if (status_code(response) == 200) {
  # Extract audio content and save the audio file
  audio_content <- content(response)$audioContent
  writeBin(base64decode(audio_content), "LinkedIn_Happy_New_Year_2025.mp3")
  
  # Play the audio file
  browseURL("LinkedIn_Happy_New_Year_2025.mp3")
} else {
  # Print error message if API call fails
  print(paste("Error:", content(response)$error$message))
}
