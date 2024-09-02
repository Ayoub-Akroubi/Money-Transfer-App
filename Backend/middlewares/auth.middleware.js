const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../config/jwt.config');

const authenticateToken = (req, res, next) => {
    const token = req.headers['authorization'];

    if (!token) {
        return res.status(401).json({ message: 'Access Denied: No Token Provided!' });
    }

    jwt.verify(token, JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({ message: 'Invalid Token' });
        }
        req.user = user;
        next();
    });
};

module.exports = authenticateToken;
