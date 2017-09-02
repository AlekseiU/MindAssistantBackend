// Package fields содержит набор служебных функций для работы с полями Data объектов
package fields

import (
	// Config
	"MindAssistantBackend/config"
	"encoding/json"
	"strings"
	// Helpers
	"MindAssistantBackend/helpers/errors"
	"MindAssistantBackend/helpers/response"
	// Interfaces
	"MindAssistantBackend/interfaces/data/fields"
	"MindAssistantBackend/interfaces/data/groups"
	// Libraries
	"net/http"
	// Packages
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

// Соединение с БД
var db = config.DbConnect()

// List выводит список полей
func List(w http.ResponseWriter, r *http.Request, group *iFieldGroup.Model) []*iField.Model {
	// Сбор и анализ входных данных
	if group.ID <= 0 {
		http.Error(w, http.StatusText(400), 400)
		return nil
	}

	// Выполнение запроса
	rows, err := db.Query("SELECT * FROM fields WHERE group_id = $1", group.ID)
	errors.ErrorHandler(err, 500, w)
	defer rows.Close()

	// Сбор данных из БД в структуру
	list := make([]*iField.Model, 0)
	for rows.Next() {
		field := new(iField.Model)

		err := rows.Scan(&field.ID, &field.Type, &field.Order, &field.Value, &field.Group)
		errors.ErrorHandler(err, 500, w)

		list = append(list, field)
	}
	errors.ErrorHandler(rows.Err(), 500, w)

	return list
}

// Update обновляет поле
func Update(w http.ResponseWriter, r *http.Request, field *iField.Model) *iField.Model {
	if field.ID <= 0 {
		http.Error(w, http.StatusText(400), 400)
		return nil
	}

	// Обработка строк
	field.Type = strings.TrimSpace(field.Type)
	field.Value = strings.TrimSpace(field.Value)

	// Подготовка запросов
	update, err := db.Prepare("UPDATE fields set type = $2, ordr = $3, value = $4, group_id = $5 where id = $1")
	errors.ErrorHandler(err, 500, w)

	// Выполнение запросов
	result, err := update.Exec(field.ID, field.Type, field.Order, field.Value, field.Group)
	errors.ErrorHandler(err, 500, w)

	rows, err := result.RowsAffected()
	errors.ErrorHandler(err, 500, w)

	// Проверка на успешность
	if rows > 0 {
		// Отображение результата
		return field
	}

	return nil
}

// Create создает поле
func Create(w http.ResponseWriter, r *http.Request) {
	// Сбор и анализ входных данных
	decoder := json.NewDecoder(r.Body)
	field := new(iField.Model)
	err := decoder.Decode(&field)
	errors.ErrorHandler(err, 500, w)
	defer r.Body.Close()

	if field.Group <= 0 {
		http.Error(w, http.StatusText(400), 400)
		return
	}

	// Обработка строк
	field.Type = strings.TrimSpace(field.Type)
	field.Value = strings.TrimSpace(field.Value)

	// Выполнение запроса
	row := db.QueryRow("INSERT INTO fields (type, ordr, value, group_id) VALUES ($1, $2, $3, $4) RETURNING id", field.Type, field.Order, field.Value, field.Group)

	err = row.Scan(&field.ID)
	errors.ErrorHandler(err, 500, w)

	// Отображение результата
	if field.ID > 0 {
		// Формирование ответа от сервера
		response := response.Set(true, "", field)

		// Подготовка выходных данных
		output, err := json.Marshal(response)
		errors.ErrorHandler(err, 500, w)

		// Отображение результата
		w.Write(output)
	}
}

// Delete удаляет поле
func Delete(w http.ResponseWriter, r *http.Request) {
	// Сбор и анализ входных данных
	params := mux.Vars(r)
	id := params["id"]
	if id == "" {
		http.Error(w, http.StatusText(400), 400)
		return
	}

	// Подготовка запроса на удаление Data объекта
	delete, err := db.Prepare("DELETE FROM fields WHERE id = $1")
	errors.ErrorHandler(err, 500, w)

	// Выполнение запросов
	delete.Exec(id)

	// Формирование ответа от сервера
	response := response.Set(true, "", nil)

	// Подготовка выходных данных
	output, err := json.Marshal(response)
	errors.ErrorHandler(err, 500, w)

	// Отображение результата
	w.Write(output)
}