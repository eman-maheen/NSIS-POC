#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
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

    // Show thanks message
    QMessageBox::information(this, "Submission Successful",
                             "Thanks for providing this information");

    // Close the window
    close();
}
