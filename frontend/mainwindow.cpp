#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>
#include <QNetworkRequest>
#include <QUrlQuery>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , networkManager(new QNetworkAccessManager(this))
{
    ui->setupUi(this);

    // Set up date picker to show current date
    ui->dateEdit->setDate(QDate::currentDate());

    // Connect submit button to slot
    connect(ui->submitButton, &QPushButton::clicked,
            this, &MainWindow::onSubmitButtonClicked);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::onSubmitButtonClicked()
{
    // Collect form data
    QString name = ui->nameLineEdit->text();
    int age = ui->ageSpinBox->value();
    QString email = ui->emailLineEdit->text();
    QDate birthDate = ui->dateEdit->date();
    QString gender = ui->genderComboBox->currentText();
    bool isStudent = ui->studentCheckBox->isChecked();

    // Validate input
    if (name.isEmpty() || email.isEmpty() ||
        gender == "Select Gender") {
        QMessageBox::warning(this, "Validation Error",
                             "Please fill in all required fields.");
        return;
    }

    // Create JSON object
    QJsonObject jsonObject;
    jsonObject["name"] = name;
    jsonObject["age"] = age;
    jsonObject["email"] = email;
    jsonObject["birth_date"] = birthDate.toString("yyyy-MM-dd");
    jsonObject["gender"] = gender;
    jsonObject["is_student"] = isStudent;

    // Convert JSON object to string
    QJsonDocument jsonDoc(jsonObject);
    QByteArray jsonData = jsonDoc.toJson();

    // Create network request
    QNetworkRequest request(QUrl("http://localhost:8000/users/"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Send POST request
    QNetworkReply *reply = networkManager->post(request, jsonData);
    connect(reply, &QNetworkReply::finished,
            [this, reply]() { handleNetworkResponse(reply); });
}

void MainWindow::handleNetworkResponse(QNetworkReply *reply)
{
    reply->deleteLater();

    if (reply->error() == QNetworkReply::NoError) {
        // Read response data
        QByteArray response = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        QJsonObject jsonObj = jsonDoc.object();

        // Show success message
        QMessageBox::information(this, "Success",
                               "Data successfully submitted to the database!");
        
        // Close the window
        close();
    } else {
        // Show error message
        QMessageBox::critical(this, "Error",
                            "Failed to submit data: " + reply->errorString());
    }
}
