const express = require('express');
const router = express.Router();
const accountController = require('../controllers/account.controller');
const authenticateToken = require('../middlewares/auth.middleware');

router.post('/deposit', authenticateToken, accountController.deposit);
router.post('/withdraw', authenticateToken, accountController.withdraw);
router.get('/getBalance', authenticateToken, accountController.getBalance);

module.exports = router;