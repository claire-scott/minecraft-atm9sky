# Use an openjdk base image
FROM openjdk:17-buster

# Install wget
RUN apt-get update && apt-get install -y curl unzip && apt-get clean

# Set the working directory
WORKDIR /minecraft

# Copy the shell script to the container
COPY download_server.sh /minecraft/download_server.sh
COPY run_server.sh /minecraft/run_server.sh

# Make the shell script executable
RUN chmod +x /minecraft/download_server.sh

# Run the shell script to download the server jar
RUN /minecraft/download_server.sh

# Add eula.txt to automatically accept the EULA
ADD eula.txt /minecraft/eula.txt

# Expose the default Minecraft server port
EXPOSE 25565

# Start the Minecraft server
#CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui"]
#CMD ["sh"]
CMD ["run_server.sh"]