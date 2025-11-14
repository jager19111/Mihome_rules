#!/bin/bash

# Директория репозитория
REPO_DIR="/etc/mihomo/mihomo_rules"
TARGET_BRANCH="main" # Проверьте имя вашей основной ветки (main или master)

# --- 1. ПЕРЕХОД В ДИРЕКТОРИЮ ---
cd "$REPO_DIR" || { echo "Ошибка: Директория репозитория не найдена." >&2; exit 1; }

# --- 2. ДОБАВЛЕНИЕ ВСЕХ ИЗМЕНЕНИЙ В STAGING ---
# Эта команда добавляет все новые и измененные файлы
/usr/bin/git add .

# --- 3. ПРОВЕРКА НАЛИЧИЯ ИЗМЕНЕНИЙ ---
# Проверяем, есть ли что коммитить (возвращает 0, если есть изменения)
if /usr/bin/git diff --cached --quiet; then
    echo "ℹ️ Нет новых изменений для коммита. Выгрузка не требуется."
    exit 0
fi

# --- 4. КОММИТ ---
COMMIT_MSG="Обновление файлов Mihomo от $(date +%Y-%m-%d)"
/usr/bin/git commit -m "$COMMIT_MSG"

# --- 5. PUSH НА GITHUB ---
/usr/bin/git push origin "$TARGET_BRANCH"

if [ $? -eq 0 ]; then
    echo "✅ Git Push выполнен успешно."
else
    echo "❌ Ошибка при выполнении Git Push. Проверьте настройки SSH-ключа." >&2
fi
