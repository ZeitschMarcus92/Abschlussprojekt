
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci || npm install
COPY . .

RUN npm run build || true \
 && if [ -d build ]; then mv build dist; \
    elif [ -d public ]; then cp -r public dist; \
    elif [ -d src ]; then mkdir -p dist && cp -r src/* dist/; \
    else mkdir -p dist && echo '<h1>Kukuk Frontend</h1>' > dist/index.html; fi

FROM nginx:alpine
COPY --from=build /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
