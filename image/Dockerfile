FROM nginx:alpine

# テスト用のHTMLファイルをコピー
COPY index.html /usr/share/nginx/html/

# ポート80を公開
EXPOSE 80

# nginxを起動
CMD ["nginx", "-g", "daemon off;"]
