# Use the official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to the root user to install additional packages
USER root

# Install any additional dependencies if needed
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    && apt-get clean

# Switch back to the Jenkins user
USER jenkins

# Expose the default Jenkins port
EXPOSE 8080

# Expose the port for JNLP agents
EXPOSE 50000

# Set the default command to run Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]