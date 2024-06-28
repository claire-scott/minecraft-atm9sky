# Use an openjdk base image
FROM openjdk:17-buster

# Install wget
RUN apt-get update && apt-get install -y curl unzip && apt-get clean

# Set the working directory
WORKDIR /server

# Copy the shell script to the container
COPY download_server.sh /server/download_server.sh
RUN chmod +x /server/download_server.sh
RUN /server/download_server.sh

COPY run_server.sh /server/run_server.sh

# Add eula.txt to automatically accept the EULA
ADD eula.txt /server/eula.txt

# Expose the default Minecraft server port
EXPOSE 25565

WORKDIR /minecraft

# Start the Minecraft server
#CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui"]
CMD ["bash"]
#CMD ["/server/run_server.sh"]