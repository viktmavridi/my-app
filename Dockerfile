# Step 1: Build Stage (to install dependencies and build app)
FROM node:18-slim AS build

# Set working directory
WORKDIR /app

# Copy only package files to leverage Docker cache
COPY package*.json ./

# Install dependencies (use npm ci for consistency and speed)
RUN npm ci --only=production

# Copy the rest of the application files
COPY . .

# Step 2: Production Stage (minimize image size)
FROM node:18-slim

# Set working directory in the final image
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Install production dependencies only
RUN npm prune --production

# Expose port 3000
EXPOSE 3000

# Use a non-root user for security (Debian style)
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
USER appuser

# Run the app
CMD ["npm", "start"]
