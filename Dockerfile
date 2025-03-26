FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Copy application code
COPY . .

# Install dependencies
RUN npm install

# Command will be provided by smithery.yaml
CMD ["node", "dist/index.js"]

