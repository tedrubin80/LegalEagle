const express = require('express');
const router = express.Router();
const clientController = require('../controllers/clientController');
const { authenticateToken } = require('../middleware/auth');

// Apply auth middleware to all routes
router.use(authenticateToken);

// Client routes
router.get('/', clientController.getClients);
router.post('/', clientController.createClient);
router.get('/:id', clientController.getClientById);
router.put('/:id', clientController.updateClient);
router.delete('/:id', clientController.deleteClient);
router.get('/:id/cases', clientController.getClientCases);
router.get('/:id/communications', clientController.getClientCommunications);

module.exports = router;