FROM node:20-alpine

WORKDIR /app

# System deps
RUN apk add --no-cache openssl

# Copy package files first
COPY package*.json ./

# Install deps
RUN npm install

# Copy full source
COPY . .

# 🔥 Build the project so dist/main.js exists
RUN npm run build

# Render-required
ENV PORT=8080
ENV SERVER_PORT=8080
EXPOSE 8080

# 🔥 Start compiled JS directly (NO tsx)
CMD ["node", "dist/main.js"]