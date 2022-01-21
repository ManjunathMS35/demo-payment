# select parent image
FROM debian:10

# Update
RUN apt update

# Install interface libraries
RUN apt-get install -y wget
 
# Install java dependencies
RUN apt install -y default-jdk && apt install -y maven

# Clean up apt lists
RUN rm -rf /var/lib/apt/lists/*

# Install maven
RUN mvn -version

# copy the source tree and the pom.xml to our new container
COPY ./ ./
 
# package our application code
RUN mvn clean install -DskipTests

RUN chmod +x /target/demo.payment-0.0.1-SNAPSHOT.jar


# set the startup command to execute the jar
ENTRYPOINT ["java", "-jar", "/target/demo.payment-0.0.1-SNAPSHOT.jar"]