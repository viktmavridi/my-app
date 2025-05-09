# Step 1: Build Stage (to install dependencies and build app)
FROM node:18-slim AS build

# Set working directory
WORKDIR /app

# Copy only package files to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Step 2: Production Stage (minimize image size)
FROM node:18-slim

# Set working directory in the final image
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
