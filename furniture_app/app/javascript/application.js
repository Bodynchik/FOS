// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
    // Категорії
    const personalDataCat = document.querySelector('#category .personal-data-cat');
    const addItemCat = document.querySelector('#add-item-cat');
    const removeItemCat = document.querySelector('#remove-item-cat');
    const itemListCat = document.querySelector('#item-list-cat');

    // Блоки даних
    const personalData = document.querySelector('.personal-data');
    const addItem = document.querySelector('.add-item');
    const removeItem = document.querySelector('.remove-item');
    const itemList = document.querySelector('.item-list');

    // Обробники подій для категорій

    // При кліку на категорію "Особиста інформація"
    personalDataCat.addEventListener('click', function() {
        // Приховати всі блоки даних крім personalData
        personalData.style.display = 'block';
        addItem.style.display = 'none';
        removeItem.style.display = 'none';
        itemList.style.display = 'none';
    });

    // При кліку на категорію "Додати товари"
    addItemCat.addEventListener('click', function() {
        // Приховати всі блоки даних крім addItem
        personalData.style.display = 'none';
        addItem.style.display = 'block';
        removeItem.style.display = 'none';
        itemList.style.display = 'none';
    });

    // При кліку на категорію "Видалити товари"
    removeItemCat.addEventListener('click', function() {
        // Приховати всі блоки даних крім removeItem
        personalData.style.display = 'none';
        addItem.style.display = 'none';
        removeItem.style.display = 'block';
        itemList.style.display = 'none';
    });

    // При кліку на категорію "Переглянути товари"
    itemListCat.addEventListener('click', function() {
        // Приховати всі блоки даних крім itemList
        personalData.style.display = 'none';
        addItem.style.display = 'none';
        removeItem.style.display = 'none';
        itemList.style.display = 'block';
    });

    // Логіка редагування даних

    const editButton = document.querySelector('.change-data-button');
    const personalDataFields = document.querySelectorAll('.personal-data-field');
    const contactDataFields = document.querySelectorAll('.contact-data-field');
    let isEditing = false;

    // Функція, що змінює активність полів редагування
    function toggleFieldsActivity(fields, isEditable) {
        fields.forEach(field => {
            if (field.tagName === 'INPUT') {
                field.disabled = !isEditable;
            } else {
                field.contentEditable = isEditable;
                if (isEditable) {
                    field.textContent = field.dataset.value || '';
                } else {
                    field.dataset.value = field.textContent;
                }
            }
        });
    }

    // Вимкнення редагування для всіх полів при завантаженні сторінки
    toggleFieldsActivity(personalDataFields, false);
    toggleFieldsActivity(contactDataFields, false);

    // Створення кнопок "Зберегти" та "Скасувати"
    function createButtons() {

        const saveButton = document.createElement('button');
        const cancelButton = document.createElement('button');

        saveButton.textContent = 'Зберегти';
        saveButton.classList.add('save-data-button');

        cancelButton.textContent = 'Скасувати';
        cancelButton.classList.add('cancel-button');

        editButton.style.display = 'none'; // Приховуємо кнопку "Редагувати"

        // Додаємо кнопки "Зберегти" та "Скасувати"
        editButton.insertAdjacentElement('afterend', saveButton);
        saveButton.insertAdjacentElement('afterend', cancelButton);

        // Обробники подій для кнопок
        saveButton.addEventListener('click', saveData);
        cancelButton.addEventListener('click', cancelEditing);

        // Додаємо клас editable до полів, щоб застосувати стилі для активного редагування
        personalDataFields.forEach(field => field.classList.add('editable'));
        contactDataFields.forEach(field => field.classList.add('editable'));
    }

    // Функція скасування редагування
    function cancelEditing() {
        const saveButton = document.querySelector('.save-data-button');
        const cancelButton = document.querySelector('.cancel-button');

        // Повертаємо попередні значення полів
        personalDataFields.forEach(field => {
            if (field.tagName === 'INPUT') {
                field.value = field.dataset.value || '';
            } else {
                field.textContent = field.dataset.value || '';
            }
        });

        contactDataFields.forEach(field => {
            if (field.tagName === 'INPUT') {
                field.value = field.dataset.value || '';
            } else {
                field.textContent = field.dataset.value || '';
            }
        });

        toggleFieldsActivity(personalDataFields, false);
        toggleFieldsActivity(contactDataFields, false);

        // Видаляємо кнопки "Зберегти" та "Скасувати"
        saveButton.remove();
        cancelButton.remove();

        // Показуємо кнопку "Редагувати" та змінюємо текст на неї
        editButton.style.display = 'inline-block'; // Показуємо кнопку "Редагувати"
        editButton.textContent = 'Редагувати';
        isEditing = false;

        // Видаляємо клас для стилізації полів
        personalDataFields.forEach(field => field.classList.remove('editable'));
        contactDataFields.forEach(field => field.classList.remove('editable'));
    }

    // Функція збереження даних
    function saveData() {
        personalDataFields.forEach(field => {
            if (field.tagName === 'INPUT') {
                field.dataset.value = field.value;
            } else {
                field.dataset.value = field.textContent;
            }
        });
        contactDataFields.forEach(field => {
            if (field.tagName === 'INPUT') {
                field.dataset.value = field.value;
            } else {
                field.dataset.value = field.textContent;
            }
        });
        cancelEditing();
    }

    // Функція перевірки заповнення всіх полів перед активацією кнопки "Зберегти"
    function checkFields() {
        let isFieldsFilled = false;
        personalDataFields.forEach(field => {
            if (field.textContent.trim() !== '') {
                isFieldsFilled = true;
            }
        });
        contactDataFields.forEach(field => {
            if (field.textContent.trim() !== '') {
                isFieldsFilled = true;
            }
        });
        const saveButton = document.querySelector('.save-data-button');
        saveButton.disabled = !isFieldsFilled;
    }

    // Додаємо обробники подій для кнопки "Редагувати"
    editButton.addEventListener('click', function() {
        if (!isEditing) {
            toggleFieldsActivity(personalDataFields, true);
            toggleFieldsActivity(contactDataFields, true);

            createButtons();

            editButton.textContent = '';
            isEditing = true;
        }
    });

    // Додаємо обробники подій для всіх полів вводу
    personalDataFields.forEach(field => {
        field.addEventListener('input', checkFields);
    });
    contactDataFields.forEach(field => {
        field.addEventListener('input', checkFields);
    });

    document.addEventListener("turbo:click", function(event) {
        const target = event.target;
        if (target.classList.contains('save-data-button')) {
            // Обробка кліку на кнопку "Зберегти"
            saveData();
        }
        if (target.classList.contains('cancel-button')) {
            // Обробка кліку на кнопку "Скасувати"
            cancelEditing();
        }
        if (target === personalDataCat) {
            // При кліку на категорію "Особиста інформація"
            personalData.style.display = 'block';
            addItem.style.display = 'none';
            removeItem.style.display = 'none';
            itemList.style.display = 'none';
        } else if (target === addItemCat) {
            // При кліку на категорію "Додати товари"
            personalData.style.display = 'none';
            addItem.style.display = 'block';
            removeItem.style.display = 'none';
            itemList.style.display = 'none';
        } else if (target === removeItemCat) {
            // При кліку на категорію "Видалити товари"
            personalData.style.display = 'none';
            addItem.style.display = 'none';
            removeItem.style.display = 'block';
            itemList.style.display = 'none';
        } else if (target === itemListCat) {
            // При кліку на категорію "Переглянути товари"
            personalData.style.display = 'none';
            addItem.style.display = 'none';
            removeItem.style.display = 'none';
            itemList.style.display = 'block';
        }
    });
});