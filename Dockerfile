FROM registry.access.redhat.com/ubi8/openjdk-17:1.14

# Set the working directory
WORKDIR /projects

# Switch to root to install additional packages if needed
USER root

# Install any additional packages if needed
# RUN microdnf install <package-name> && microdnf clean all

# Switch back to default user (jboss)
USER jboss

# Copy the project files
COPY src/main/resources/docker/settings.xml /home/jboss/.m2/
COPY pom.xml /projects/
COPY src /projects/src

# Install dependencies
# RUN mvn dependency:go-offline

# Expose the application port
EXPOSE 8080

# Add debugging steps
RUN echo "Contents of /projects:" && ls -la /projects
RUN echo "Contents of /home/jboss:" && ls -la /home/jboss

# Set the entrypoint to run the application in dev mode with debugging
ENTRYPOINT ["/bin/sh", "-c", "echo 'Starting Quarkus in dev mode' && mvn quarkus:dev -Dquarkus.http.host=0.0.0.0"]