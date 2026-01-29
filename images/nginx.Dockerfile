FROM nginx:alpine

# Add necessary packages
RUN apk --no-cache add curl

# Create directory for PID file
RUN mkdir -p /var/run/nginx

# Remove default configuration
RUN rm /etc/nginx/conf.d/default.conf

# Set proper permissions
RUN chmod -R 755 /var/cache/nginx /var/log/nginx /var/run/nginx

# Copy custom configurations if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]