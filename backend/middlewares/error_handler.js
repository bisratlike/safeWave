const errorHandler = (err, req, res, next) => {
    const statusCode = err.statusCode || 500;
    let message = err.message || ' ';

    switch (statusCode) {
        case 400:
            message = 'Bad Request: ' + message;
            break;
        case 401:
            message = 'Unauthorized: ' + message;
            break;
        case 403:
            message = 'Forbidden: ' + message;
            break;
        case 404:
            message = 'Not Found: ' + message;
            break;
        case 405:
            message = 'Method Not Allowed: ' + message;
            break;
        case 500:
            message = 'Internal Server Error: ' + message;
            break;
        default:
            message = 'Unexpected error occurred: ' + message;
            break;
    }

    console.error(`Error: ${message} - Status: ${statusCode}`);


    res.status(statusCode).json({
        success: false,
        status: statusCode,
        message: message,
    });
};

module.exports = errorHandler;
