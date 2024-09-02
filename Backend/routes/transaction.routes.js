const express = require('express');
const router = express.Router();
const transactionController = require('../controllers/transaction.controller');
const authenticateToken = require('../middlewares/auth.middleware');

router.get('/getTransactions', authenticateToken, transactionController.getTransactions );
router.post('/initiateTransfer', authenticateToken, transactionController.initiateTransfer );
router.put('/matchAgent', authenticateToken, transactionController.matchAgent );
router.put('/completeTransaction', authenticateToken, transactionController.completeTransaction );

module.exports = router;