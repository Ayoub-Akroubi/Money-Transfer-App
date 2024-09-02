const express = require('express');

const router = express.Router();
const authRoutes = require('./auth.routes');
const userRoutes = require('./user.routes');
const accountRoutes = require('./account.routes');
const transactionRoutes = require('./transaction.routes');

router.use(authRoutes);
router.use(userRoutes);
router.use(accountRoutes);
router.use(transactionRoutes);

module.exports = router;