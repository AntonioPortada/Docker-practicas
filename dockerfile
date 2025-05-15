# Use an official Nginx image as the base image
FROM nginx:alpine

# Copy the static HTML files to the Nginx default directory
COPY ./index.html /usr/share/nginx/html

# Expose port 80 to serve the static website
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]